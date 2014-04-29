Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s3TGFx5I008461
 for <selinux@tycho.nsa.gov>; Tue, 29 Apr 2014 12:15:59 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com
 (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
 by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s3TGFj7o004310
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
 for <selinux@tycho.nsa.gov>; Tue, 29 Apr 2014 12:15:46 -0400
Received: from [10.13.137.74] (dhcp137-74.rdu.redhat.com [10.13.137.74])
 by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id
 s3TGFjlK012726
 for <selinux@tycho.nsa.gov>; Tue, 29 Apr 2014 12:15:45 -0400
Message-ID: <1398788145.3576.70.camel@metroid.usersys.redhat.com>
Subject: SELINUX=disabled vs. "enforce=1"
From: Will Woods <wwoods@redhat.com>
To: selinux@tycho.nsa.gov
Date: Tue, 29 Apr 2014 12:15:45 -0400
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

So in libselinux/src/load_policy.c:selinux_init_load_policy(), it says:
        /* 
         * Determine the final desired mode.
         * Command line argument takes precedence, then config file. 
         */
        if (secmdline >= 0)
                *enforce = secmdline;
        else if (seconfig >= 0)
                *enforce = seconfig;
        else
                *enforce = 0;   /* unspecified or disabled */

But then a few lines later, we have:
        if (seconfig == -1) {
                /* Runtime disable of SELinux. */
                rc = security_disable();
                [etc.]

...so if the config file says "disabled", SELinux is disabled
*regardless* of the command line argument. 

Is that intentional, or is that a bug? Maybe that test should read:

        if ((seconfig == -1) && (secmdline <= -1)) {

Any ideas?

-w
