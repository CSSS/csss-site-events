import type { NavItem, SiteConfig } from '@csss-site-events/ui/types';

export const navItems: NavItem[] = [
  {
    label: 'Link',
    href: '/tech-fair/2026'
  },
  {
    label: 'Link',
    children: [
      {
        label: 'Link 1',
        href: 'link/to/1'
      }
    ]
  },
  {
    label: 'Link',
    children: [
      {
        label: 'Link 1',
        href: 'link/to/1'
      }
    ]
  },
  {
    label: 'Link',
    href: '/tech-fair/2026'
  },
  {
    label: 'Link',
    children: [
      {
        label: 'Link 1',
        href: 'link/to/1'
      }
    ]
  }
];

export const siteConfig: SiteConfig = {
  name: 'Tech Fair 2026',
  title: 'Tech Fair 2026',
  description: 'Description',
  eventName: 'Tech Fair 2026'
};
