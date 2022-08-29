/**
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 *
 * @format
 */
// @ts-check
// Note: type annotations allow type checking and IDEs autocompletion

/** @type {import('@docusaurus/types').Config} */


const config = {
  title: 'siMMMulator',
  tagline: 'An Open Source Method to Generate Data for Marketing Mix Models',
  url: 'https://facebookexperimental.github.io',
  baseUrl: '/',
  onBrokenLinks: 'ignore',
  onBrokenMarkdownLinks: 'warn',
  favicon: 'img/favicon.ico',
  organizationName: 'facebookexperimental', // Usually your GitHub org/user name.
  projectName: 'siMMMulator', // Usually your repo name.
  deploymentBranch: "gh-pages",
  trailingSlash: false,

  presets: [
    [
      'classic',
      /** @type {import('@docusaurus/preset-classic').Options} */
      ({
        docs: {
          sidebarPath: require.resolve('./sidebars.js'),
          // Please change this to your repo.
          editUrl:
            'https://github.com/facebookexperimental/siMMMulator/tree/gh-pages',
        },
        theme: {
          customCss: require.resolve('./src/css/custom.css'),
        },
      }),
    ],
  ],

  themeConfig:
    /** @type {import('@docusaurus/preset-classic').ThemeConfig} */
    ({
      navbar: {
        title: 'siMMMulator',
        logo: {
          alt: 'siMMMulator Logo',
          src: 'img/siMMMulator_logo.png',
        },
        items: [
          {
            type: 'doc',
            docId: 'about_simmmulator',
            position: 'left',
            label: 'About SiMMMulator',
          },
          {
            type: 'doc',
            docId: 'set_up',
            position: 'left',
            label: 'Using siMMMulator',
          },
          {
            type: 'doc',
            docId: 'FAQ and Support',
            position: 'left',
            label: 'FAQ and Support',
          },
        ],
      },
      footer: {
        style: 'dark',
        links: [
          {
            title: 'Learn',
            items: [
              {
                label: 'About siMMMulator',
                to: 'docs/about_simmmulator',
              },
              {
                label: 'Setting Up siMMMulator',
                to: 'docs/set_up',
              },
              {
                label: 'Step-by-Step Guide',
                to: 'docs/step_by_step_guide',
              },
              {
                label: 'Demo Code',
                to: 'docs/demo_code',
              },
              {
                label: 'FAQ and support',
                to: 'docs/FAQ and Support',
              },
            ],
          },
          {
            title: 'More',
            items: [
              {
                label: 'GitHub',
                href: 'https://github.com/facebookexperimental/siMMMulator',
              },
              {
                label: 'Facebook Group',
                href: 'https://www.facebook.com/groups/1709945532706010/',
              },
            ],
          },
          {
            title: 'Legal',
            // Please do not remove the privacy and terms, it's a legal requirement.
            items: [
              {
              label: 'Privacy',
              href: 'https://opensource.fb.com/legal/privacy/',
              target: '_blank',
              rel: 'noreferrer noopener',
            },
            {
              label: 'Terms',
              href: 'https://opensource.fb.com/legal/terms/',
              target: '_blank',
              rel: 'noreferrer noopener',
            },
              {
                label: 'Data Policy',
                href: 'https://opensource.facebook.com/legal/data-policy/',
              },
              {
                label: 'Cookie Policy',
                href: 'https://opensource.facebook.com/legal/cookie-policy/',
              },
            ],
          },
        ],
        logo: {
          alt: 'Meta Open Source Logo',
          src: 'img/meta_opensource_logo_negative.svg',
          href: 'https://opensource.facebook.com',
        },
        // Please do not remove the credits, help to publicize Docusaurus :)
        copyright: `Copyright © ${new Date().getFullYear()} Meta Platforms, Inc. Built with Docusaurus.`,
      },
    }),
};

module.exports = config;
