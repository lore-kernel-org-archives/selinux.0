Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v72G0JXp027324
 for <selinux@tycho.nsa.gov>; Wed, 2 Aug 2017 12:00:19 -0400
Received: by mail-ua0-f180.google.com with SMTP id q25so22499424uah.1
 for <selinux@tycho.nsa.gov>; Wed, 02 Aug 2017 08:41:44 -0700 (PDT)
MIME-Version: 1.0
From: Carlos Rodrigues <cefrodrigues@gmail.com>
Date: Wed, 2 Aug 2017 16:41:00 +0100
Message-ID: <CAENH-vA_rbUf8UyDcGmCto3-R9zNPy1jMMoH+XKwRqx7c4P-qQ@mail.gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
Subject: httpd_graceful_shutdown makes httpd_can_network_connect mostly mute
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi,

I don't know if this a too basic question to ask here, or the proper
place, but here it goes:

I've been chasing some weird (to me) behavior with the targeted policy
on a VM running nginx as a reverse proxy. What happens is that the
"httpd_can_network_connect" boolean needs to be enabled for nginx to
be able to reach its upstream servers. So far, so good.

However, if the upsteam server happens to be listening in one of the
"http_port_t" ports, "httpd_can_network_connect" isn't needed because
the "httpd_graceful_shutdown" (default enabled) provides the required
allow rule ("name_connect").

This seems strange to me. Is this supposed to be like this? I would
expect nginx to be totally unable to establish outbound connections by
default.

Best regards,

Carlos Rodrigues

PS: I just spent a few hours on this, wondering why one machine needed
"httpd_can_network_connect" and another did not. I guess I've mostly
been setting up reverse proxies for "http_port_t" upstreams on CentOS
all this time...
