import { brandColours } from './common.data';

/**
 * The type of a navigation entry.
 */
export type NavItem =
  | {
      label: string;
      href: string;
    }
  | {
      label: string;
      children: NavItem[];
    };

export type BrandColour = (typeof brandColours)[number];

/**
 * The configuration for a website.
 *
 * `name`: full name of the website, used for display and SEO purposes
 * `title`: title to be used in the <title> tag of the index of the website
 * `description`: description of the website, used for SEO purposes
 * `eventName`: full name of the event, could be the same as `name` if there is no alias e.g. Tech Fair 2026 vs Retro Frosh (Frosh 2023)
 */
export interface SiteConfig {
  name: string;
  title: string;
  description: string;
  eventName: string;
}
