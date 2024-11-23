import { Application } from "stimulus";
import { definitionsFromContext } from "stimulus/webpack-helpers";
import { Turbo } from "@hotwired/turbo-rails";
Turbo.session.drive = false;
// Створення Stimulus додатка
const application = Application.start();

// Завантаження контролерів Stimulus
const context = require.context("controllers", true, /\.js$/);
application.load(definitionsFromContext(context));
