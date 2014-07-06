Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s66DC3C0024178
 for <selinux@tycho.nsa.gov>; Sun, 6 Jul 2014 09:12:03 -0400
Received: by mail-wg0-f45.google.com with SMTP id z12so1425809wgg.4
 for <selinux@tycho.nsa.gov>; Sun, 06 Jul 2014 06:12:05 -0700 (PDT)
Received: from [192.168.1.101] ([84.245.1.4])
 by mx.google.com with ESMTPSA id bq7sm102964262wib.7.2014.07.06.06.12.03
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=RC4-SHA bits=128/128);
 Sun, 06 Jul 2014 06:12:04 -0700 (PDT)
Message-ID: <1404652323.9852.49.camel@x220.localdomain>
Subject: Re: secilc: is anyone able to confirm that type_change ...
From: Dominick Grift <dominick.grift@gmail.com>
To: selinux@tycho.nsa.gov
Date: Sun, 06 Jul 2014 15:12:03 +0200
In-Reply-To: <1404563967.9852.42.camel@x220.localdomain>
References: <1404563967.9852.42.camel@x220.localdomain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sat, 2014-07-05 at 14:39 +0200, Dominick Grift wrote:
> ... rules are no longer honored using policy compiled with any of the
> recent secilc revisions?
> 
> My login programs no longer relabel my login tts/pts, even though my
> policy has, what i believe are, proper type_change rules.
> 
> 

the compute_relabel command from libselinux-utils does the right thing.
Still for some reason the login programs do not relabelto the type. (the
identity is relabeled)

How can this be? sesearch shows the type_change rules, compute_relabel
shows the expected result, yet some how all login program's i have tried
consistently ignore the type (but not the identity)

I have been running SSHD in debug mode in hopes to get some more
information but as far as SSHD is concerned all is fine. It almost seems
it is just not aware of the type (needless to say the type is there and
usable)
