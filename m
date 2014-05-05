Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s45G6m4I006608
 for <selinux@tycho.nsa.gov>; Mon, 5 May 2014 12:06:48 -0400
Received: by mail-ig0-f176.google.com with SMTP id hl10so4928025igb.15
 for <selinux@tycho.nsa.gov>; Mon, 05 May 2014 09:06:48 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 5 May 2014 12:06:47 -0400
Message-ID: <CANnpg5Q8Uf23hKB1s3OtOQiXJSuUh5hyB08wkecWQ6U7oMusBA@mail.gmail.com>
Subject: staff_u permission
From: Steve Huston <huston@astro.princeton.edu>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Apologies if this subject doesn't make sense, I'm not only fairly new
to selinux but also on Sudafed :>

I'm setting up a Puppet server, and will have a Mercurial repository
behind it; as a post-push hook I will have hg do a checkout of the
repo to /etc/puppet (after having done some sanity checks on the
changeset).  Right now, all the files in /etc/puppet are owned by root
with a group that I and another can access, and have the context
system_u:object_r:puppet_etc_t.

My user account is part of the staff_u context, and I would like to
tell selinux on this machine that anyone in that context should be
allowed to edit those files.  Looking through with "sesearch -A -t
puppet_etc_t -c file -p write" I see the puppet_t context allows such.
 What I do not know is how to configure a transition or what else I
could/should do to allow staff_u to write to just those files.  While
I'm sure I could use a larger hammer, I would like to be in the
practice of only allowing what should be allowed by default, and not a
larger amount of permission just because it's easier.

Can someone point me to the proper documentation for this?  If you
want to spell out the answer that's great too, provided you tell me
how you got it :>

-- 
Steve Huston - W2SRH - Unix Sysadmin, PICSciE/CSES & Astrophysical Sci
  Princeton University  |    ICBM Address: 40.346344   -74.652242
    345 Lewis Library   |"On my ship, the Rocinante, wheeling through
  Princeton, NJ   08544 | the galaxies; headed for the heart of Cygnus,
    (267) 793-0852      | headlong into mystery."  -Rush, 'Cygnus X-1'
