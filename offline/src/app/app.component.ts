import { Component } from '@angular/core';
import { ApiService } from './api.service';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent {
  title = 'leaderboard';
  cars = [];
  showLastLap = true;

  constructor(private api: ApiService) {
    this.api.getData().then((res: any) => {
      if (res) {
        this.cars = res.sort((a, b) => a.position - b.position);
      }
    });
    setInterval(() => {
      this.showLastLap = !this.showLastLap;
      this.api.getData().then((res: any) => {
        if (res) {
          this.cars = res.sort((a, b) => a.position - b.position);
        }
      });
    }, 1000);
  }

  getFormatted(lap) {
    return lap.toFixed(3);
  }
}
