Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u56MHP9G020031
 for <selinux@tycho.nsa.gov>; Mon, 6 Jun 2016 18:17:26 -0400
Received: by mail-qg0-f54.google.com with SMTP id 93so49786060qgx.2
 for <selinux@tycho.nsa.gov>; Mon, 06 Jun 2016 15:17:22 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Problem building CLIP ISO
From: Brandon Whalen <brandon@quarksecurity.com>
In-Reply-To: <17ff81b08dae0262ca3caa4ee4c4e516@mail.vivaldi.net>
Date: Mon, 6 Jun 2016 18:17:21 -0400
Cc: clip@oss.tresys.com, selinux@tycho.nsa.gov
Message-Id: <9A09501E-CDD5-42FB-BE54-16ED300427E5@quarksecurity.com>
References: <17ff81b08dae0262ca3caa4ee4c4e516@mail.vivaldi.net>
To: John Chludzinski <john.chludzinski@vivaldi.net>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

> On Jun 6, 2016, at 5:45 PM, John Chludzinski <john.chludzinski@vivaldi.net> wrote:
> 
> I ran:
> 
> $ git clone -b CLIP_RHEL_7.0_Final https://github.com/TresysTechnology/clip.git
> 
> As root, I ran:
> 
> $ ./bootstrap.sh
> 
> and got ...
> 
> <username> cannot register with any organizations.
> 
> So I tried:
> 
> $ subscription-manager register --username <username> --password <passwor> --auto-attach
> 
> and got ...
> 
> <username> cannot register with any organizations.
> 
> 
> What’s
> the solution?
> 

I’ve added the clip mailing list to this thread John. Please use the CLIP mailing list and not the SELinux one for these types of questions in the future. The two groups work together but people don’t always watch both.

Did you look at the boostrap.sh script to see what it is doing?

> 
> ---John
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
