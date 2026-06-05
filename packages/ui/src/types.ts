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
      dropdown: NavItem[];
    };

export const socialLinks = {
  website: 'https://sfucsss.org',
  discord: 'https://discord.gg/sfucsss',
  instagram: 'https://www.instagram.com/sfu_csss/',
  linkedin: 'https://ca.linkedin.com/company/sfucsss',
  facebook: 'https://www.facebook.com/sfucsss'
};

/**
 * The configuration for a website.
 *
 * `name`: full name of the website, used for display purposes
 * `title`: title to be used in the <title> tag of the website
 * `description`: description of the website, used for SEO purposes
 * `eventName`: full name of the event
 */
export interface SiteConfig {
  name: string;
  title: string;
  description: string;
  eventName: string;
}
