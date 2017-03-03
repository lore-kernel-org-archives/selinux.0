Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v23KJjg2021290
 for <selinux@tycho.nsa.gov>; Fri, 3 Mar 2017 15:19:45 -0500
Date: Fri, 3 Mar 2017 15:19:41 -0500 (EST)
From: Simon Sekidde <ssekidde@redhat.com>
To: Ian Pilcher <arequipeno@gmail.com>
Cc: Systemd <systemd-devel@lists.freedesktop.org>, selinux@tycho.nsa.gov
Message-ID: <1353314837.27730740.1488572381714.JavaMail.zimbra@redhat.com>
In-Reply-To: <ed928821-bc0d-331f-ce94-44a38dd3b4ff@gmail.com>
References: <51816900-3b52-8eb6-bf86-75aa8540fca3@gmail.com>
 <20170301222511.GA29059@gardel-login>
 <944362898.27340550.1488467628547.JavaMail.zimbra@redhat.com>
 <3cf89bd9-7f2b-81d0-c531-db6890cc2fee@gmail.com>
 <333322329.27680470.1488556919299.JavaMail.zimbra@redhat.com>
 <44544158.27690099.1488559508818.JavaMail.zimbra@redhat.com>
 <ed928821-bc0d-331f-ce94-44a38dd3b4ff@gmail.com>
Subject: Re: [systemd-devel] SELinux type transition rule not working
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



----- Original Message -----
> From: "Ian Pilcher" <arequipeno@gmail.com>
> To: "Simon Sekidde" <ssekidde@redhat.com>
> Cc: "Systemd" <systemd-devel@lists.freedesktop.org>, selinux@tycho.nsa.gov
> Sent: Friday, March 3, 2017 2:32:54 PM
> Subject: Re: [systemd-devel] SELinux type transition rule not working
> 
> On 03/03/2017 10:45 AM, Simon Sekidde wrote:
> > Ian do you have a copy of this custom policy somewhere?
> 
> https://github.com/ipilcher/squoxy/blob/master/squoxy.te
> 

Thanks. Lets try to get a template going and we can help clean it up. 

 sepolicy generate --init -n squoxy /usr/local/bin/squoxy

> --
> ========================================================================
> Ian Pilcher                                         arequipeno@gmail.com
> -------- "I grew up before Mark Zuckerberg invented friendship" --------
> ========================================================================
> 

-- 
Simon Sekidde * Red Hat, Inc. * Tyson's Corner, VA
Solution Architect, NA Public Sector
ssekidde@redhat.com | (w) 978-392-1074 | (m) 571-551-9366 | @ssekidde
gpg: 5848 958E 73BA 04D3 7C06 F096 1BA1 2DBF 94BC 377E
