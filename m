Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v23L0bAZ003551
 for <selinux@tycho.nsa.gov>; Fri, 3 Mar 2017 16:00:37 -0500
Received: by mail-ot0-f194.google.com with SMTP id x37so5440942ota.1
 for <selinux@tycho.nsa.gov>; Fri, 03 Mar 2017 13:00:21 -0800 (PST)
Subject: Re: [systemd-devel] SELinux type transition rule not working
To: Simon Sekidde <ssekidde@redhat.com>
References: <51816900-3b52-8eb6-bf86-75aa8540fca3@gmail.com>
 <20170301222511.GA29059@gardel-login>
 <944362898.27340550.1488467628547.JavaMail.zimbra@redhat.com>
 <3cf89bd9-7f2b-81d0-c531-db6890cc2fee@gmail.com>
 <333322329.27680470.1488556919299.JavaMail.zimbra@redhat.com>
 <44544158.27690099.1488559508818.JavaMail.zimbra@redhat.com>
 <ed928821-bc0d-331f-ce94-44a38dd3b4ff@gmail.com>
 <1353314837.27730740.1488572381714.JavaMail.zimbra@redhat.com>
Cc: Systemd <systemd-devel@lists.freedesktop.org>, selinux@tycho.nsa.gov
From: Ian Pilcher <arequipeno@gmail.com>
Message-ID: <acc4b5a7-4508-1ff7-ed67-67e9d208383f@gmail.com>
Date: Fri, 3 Mar 2017 15:00:19 -0600
MIME-Version: 1.0
In-Reply-To: <1353314837.27730740.1488572381714.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/03/2017 02:19 PM, Simon Sekidde wrote:
> Thanks. Lets try to get a template going and we can help clean it up.

I've been scrambling to get my home network setup (after migrating the
main network server/router from CentOS 6 -> 7), so it's not surprise if
things are a bit hacky right now.

>  sepolicy generate --init -n squoxy /usr/local/bin/squoxy

Yet another tool that I've never heard of before.  So much outdated
info on SELinux out there.  :-(

-- 
========================================================================
Ian Pilcher                                         arequipeno@gmail.com
-------- "I grew up before Mark Zuckerberg invented friendship" --------
========================================================================
