Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s5PJErhi004652
 for <selinux@tycho.nsa.gov>; Wed, 25 Jun 2014 15:14:53 -0400
Received: by mail-qg0-f43.google.com with SMTP id z60so2131718qgd.30
 for <selinux@tycho.nsa.gov>; Wed, 25 Jun 2014 12:14:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAEFn6A4mzF208e1s_OHEzJ-1Kq-DUGgzVNbQXrW6NbB0e8DSpQ@mail.gmail.com>
References: <CAEFn6A4mzF208e1s_OHEzJ-1Kq-DUGgzVNbQXrW6NbB0e8DSpQ@mail.gmail.com>
Date: Wed, 25 Jun 2014 15:14:56 -0400
Message-ID: <CAB9W1A3HhfPimsRB4Qtf91hCM8u2Ds+yzK9XBYr6eEcdDP+wWQ@mail.gmail.com>
Subject: Fwd: Booting time is increased after applying kernel 3.10
From: Stephen Smalley <stephen.smalley@gmail.com>
To: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@parisplace.org>,
 selinux <selinux@tycho.nsa.gov>, Jaejyn Shin <flagon22bass@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

(fwd to selinux list as this is a general selinux kernel issue)

---------- Forwarded message ----------
From: Jaejyn Shin <flagon22bass@gmail.com>
Date: Wed, Jun 25, 2014 at 4:36 AM
Subject: Booting time is increased after applying kernel 3.10
To: "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>



Dear SEAndroid and SELinux developer
First of all, I always appreciate that I get lots of information in
this e-mailing list.

After applying kernel 3.10, the booting time of my device has been increased
Especially, the selinux initializing time is increased (about 0.5s).

I analized the reason, and I found that the synchronize_net function
has 0.1s delay.

before)
selinux_initialize
    -> selinux_android_load_policy
   -> selinux_android_reload_policy
   -> security_load_policy
   -> avc_ss_reset
   -> sel_netport_avc_callback -> synchronize_net
-> sel_netnode_avc_callback -> synchronize_net
-> sel_netif_avc_callback -> synchronize_net
    -> security_setenforce
   -> sel_write_enforce
   -> avc_ss_reset
-> sel_netport_avc_callback -> synchronize_net
   -> sel_netnode_avc_callback -> synchronize_net
-> sel_netif_avc_callback -> synchronize_net
To make fast the booting time, can I don't call the avc_ss_reset
function only during initializing selinux ?

after)
selinux_initialize
    -> selinux_android_load_policy
   -> selinux_android_reload_policy
   -> security_load_policy
   X-> avc_ss_reset
    -> security_setenforce
   -> sel_write_enforce
   X-> avc_ss_reset

Is it possible?

Thank you
Best regards

_______________________________________________
Seandroid-list mailing list
Seandroid-list@tycho.nsa.gov
To unsubscribe, send email to Seandroid-list-leave@tycho.nsa.gov.
To get help, send an email containing "help" to
Seandroid-list-request@tycho.nsa.gov.
