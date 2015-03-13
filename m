Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t2DIhYMB002494
 for <selinux@tycho.nsa.gov>; Fri, 13 Mar 2015 14:43:35 -0400
Received: by widex7 with SMTP id ex7so8553681wid.3
 for <selinux@tycho.nsa.gov>; Fri, 13 Mar 2015 11:43:33 -0700 (PDT)
Received: from linksys-wireless-usb.network2 (84-245-31-108.dsl.cambrium.nl.
 [84.245.31.108])
 by mx.google.com with ESMTPSA id w8sm3957303wja.4.2015.03.13.11.43.32
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 13 Mar 2015 11:43:32 -0700 (PDT)
Date: Fri, 13 Mar 2015 19:43:31 +0100
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: Strange behavior: type boundaries
Message-ID: <20150313184330.GC9437@linksys-wireless-usb.network2>
References: <20150313181459.GB9437@linksys-wireless-usb.network2>
 <55032BCD.7090103@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
In-Reply-To: <55032BCD.7090103@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Fri, Mar 13, 2015 at 02:26:21PM -0400, Stephen Smalley wrote:
> On 03/13/2015 02:15 PM, Dominick Grift wrote:
> > I was playing with systemd-nspawn/machine, and machinectl allows one to pull in images. I am trying to confine it and i hit issues:
> > 
> > systemd runs systemd-importd, and systemd-importd runs systemd-pull
> > 
> > It seems as if though its some multithreading going on because i get:
> > 
> > type=SELINUX_ERR msg=audit(1426268982.258:2559): op=security_bounded_transition seresult=denied oldcontext=system_u:system_r:systemd_t newcontext=system_u:system_r:importd_t
> > 
> > Even though I am in permissive mode, and a transition rule "allow systemd_t importd_t:process transition;" is present, SELinux does not transition.
> > 
> > When i add a typebounds statement (typebounds systemd_t importd_t), then the scenario changes:
> > 
> > type=SELINUX_ERR msg=audit(1426268121.044:2414): op=security_compute_av reason=bounds scontext=system_u:system_r:systemd_t tcontext=system_u:system_r:importd_t tclass=process perms=transition
> > ----
> > type=AVC msg=audit(1426268121.044:2415): avc:  denied  { transition } for  pid=9210 comm="(-importd)" path="/usr/lib/systemd/systemd-importd" dev="dm-1" ino=2232532 scontext=system_u:system_r:systemd_t tcontext=system_u:system_r:importd_t tclass=process permissive=1
> > ----
> > type=SELINUX_ERR msg=audit(1426268121.044:2416): op=security_compute_av reason=bounds scontext=system_u:system_r:importd_t tcontext=system_u:object_r:importd_exec_t tclass=file perms=entrypoint
> > ----
> > type=AVC msg=audit(1426268121.044:2417): avc:  denied  { entrypoint } for  pid=9210 comm="(-importd)" path="/usr/lib/systemd/systemd-importd" dev="dm-1" ino=2232532 scontext=system_u:system_r:importd_t tcontext=system_u:object_r:importd_exec_t tclass=file permissive=1
> > ----
> > type=SELINUX_ERR msg=audit(1426268121.046:2418): op=security_compute_av reason=bounds scontext=system_u:system_r:importd_t tcontext=system_u:system_r:systemd_t tclass=fd perms=use
> > ----
> > type=AVC msg=audit(1426268121.046:2419): avc:  denied  { use } for  pid=9210 comm="systemd-importd" path="/dev/null" dev="devtmpfs" ino=1028 scontext=system_u:system_r:importd_t tcontext=system_u:system_r:systemd_t tclass=fd permissive=1
> > 
> > These rules are present in the policy (the transition is obviously taking place in permissive mode) and so is the typebounds rule, but access looks still denied.
> > 
> > I do not understand what is going on here.
> > 
> > First of all importd_t is bounded to systemd. So why does it appear to be a problem that systemd operates on importd_t entities?
> > 
> > Also why does selinux refuse to type transition without a typebounds, and why does it give me a permission denied with a typebounds 
> 
> NO_NEW_PRIVS?  See http://marc.info/?l=selinux&m=140717412324539&w=2
> Previously domain transitions on exec were always disabled under
> NO_NEW_PRIVS and nosuid mounts.  This was introduced as a way of
> supporting e.g. the SELinux sandbox or other cases where NNP is being
> used and they want to transition domains on exec.  Typebounds makes this
> safe, but typebounds requires you to cap the child type's permissions to
> a subset of the parent type's permissions.  This is normally checked by
> checkpolicy or libsemanage at policy build/link time but I'm sure Red
> Hat has disabled it along with neverallow checking, so you probably
> don't see it until the kernel recognizes the discrepancy and dynamically
> blocks the access that would violate the bound.

Yes that is what i mentioned on #selinux. However i am not using checkpolicy or libsemanage. I am using secilc (and i have it check for neverallow rule violations). I would have expected it to catch it on compile time.

However there is still something strange in that importd_t is bounded to systemd_t: thus why would: "systemd_t importd_t:process transition;" be denied?

systemd_t is the parent and not the bounded child.

A rule "allow systemd_t importd_t:process transition;" is present in the output of "sesearch -A -s systemd_t -t importd_t". Yet it still prints a denial.

> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.

- -- 
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
http://keys.gnupg.net/pks/lookup?op=vindex&search=0x314883A202DFF788
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJVAy/OAAoJENAR6kfG5xmcrpwL/jzgt80iZDtJoQKBd90MzV/W
Z9ldbnPK13hWpYGTJxOTS8MknMMUwb3wT9nBwMeg6rF8K6lNvutsXxHEGHzgMwdT
WpYlI2gH/TUba8PL9poV7sL+tCdjpR5pAbQiZmFYZHYvlH2xg2jlSJ2a4lEwCKxJ
Y3YnMUYTVBUjWqYzzVsTtwu939MqDGpON77NO/TtJ4eogAb5eNeybxZnDZPHPc7m
qgYCV3KBFBmNH6aslaVV/U0U+/n3VOjVoZS0g9IKFoRn1noOONeERbzj9Lw1vxek
cytAvnDGqofRRVd7b2WpCrFVUjdniI/keg6kVXfPpwuTLPiIm/g+RGymkMWvGEbH
O7fGurpoHDKj1XMOAn9LbgRaHQoaAUpaW2VpOLCkt0lAnQK9nQHSWq5lf6VcgQSQ
vB2miUPeELW2o3LhltL+5gCiBEvjkuaBqYj+h0n2YBG9JzXvwvT1g/qNA1kkWpLp
Yq4hIoVemD5ObjD3xJCr3w1IH3FpvloMY4s/2EmZfA==
=hnz3
-----END PGP SIGNATURE-----
