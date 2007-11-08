Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lA8KtmGI018617
	for <selinux@tycho.nsa.gov>; Thu, 8 Nov 2007 15:55:48 -0500
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id lA8KtgMZ000132
	for <selinux@tycho.nsa.gov>; Thu, 8 Nov 2007 20:55:42 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.14.1/8.14.1) with ESMTP id lA8KnQV0012373
	for <selinux@tycho.nsa.gov>; Thu, 8 Nov 2007 15:49:26 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.14.1/8.14.1/Submit) id lA8KnQSo012372
	for selinux@tycho.nsa.gov; Thu, 8 Nov 2007 15:49:26 -0500
Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lA8IcGPP001837
	for <selinux@tycho.nsa.gov>; Thu, 8 Nov 2007 13:38:16 -0500
Message-ID: <47335759.7060600@tycho.nsa.gov>
Date: Thu, 08 Nov 2007 13:37:13 -0500
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Jim Meyering <jim@meyering.net>
CC: SE Linux <selinux@tycho.nsa.gov>, bug-coreutils@gnu.org
Subject: Re: should GNU install call matchpathcon by default?
References: <87k5ou9trs.fsf@rho.meyering.net>
In-Reply-To: <87k5ou9trs.fsf@rho.meyering.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Jim Meyering wrote:
> Hi,
> 
> This morning I noticed a flagrant difference in the speed of
> "make install" for the just-released gettext-0.17.  It took 12(!)
> times longer on a rawhide system than on a usually-slower debian
> unstable system. (3min vs. 15s)
> 
> I tracked it down to the fact that on that rawhide system, I'm using
> the latest _upstream_ install binary from (SELinux-enabled) coreutils.
> The rawhide /usr/bin/install only ever calls matchpathcon (via
> setdefaultfilecon) when its final chown or chmod fails.  Looks like
> a fortuitous bug in the rawhide patch.  The version of install from
> upstream coreutils calls it every time, since that's the only thing that
> made sense to me when I redid coreutils' SELinux support.  Considering no
> one can be relying on install's matchpathcon semantics, even in rawhide,
> I think it should not be the default, upstream -- especially considering
> the enormous performance hit.
> 
> Any objections or suggestions from the SELinux folks?

Don't have a suggestion on the usage, but your overhead is coming from 
the loading of the file contexts database on each invocation of 
/bin/install.  You could try to make the gettext installer more 
judicious about batching things into a single /bin/install command line. 
  Or make install a shell builtin, so that it's not a separate process.

There is a new handle-based set of calls that replaces matchpathcon() 
and friends.  See include/selinux/label.h.  If you're rewriting this 
part of the code, I'd recommend switching over.  It won't affect 
performance too much I'm afraid, but maybe at some point there will be a 
daemon backend of some sort so it just makes an IPC call instead of 
loading the database in the library code.


> 
> Do you think coreutils' install should use matchpathcon at all?  If so,
> either it'll have to be associated with a new option, or it'll have
> to be a lot more efficient.  Yes, we've discussed this before, and
> you guys convinced me to provide the functionality for ease of use.
> But for those not familiar with the issues, note that you can get the
> same effect without the embedded matchpathcon call, simply by invoking
> install with a context provided by the matchpathcon _program_:
> 
>   install -Z $(matchpathcon $dest_file) SRC_FILE $dest_file
> 
> Can someone can look at making matchpathcon more efficient?  I understand
> that making it the default would be nice, and if it's feasible to minimize
> the performance impact of that matchpathcon call, it'd be much better *not*
> to add a new option.
> 
> Unless I find a magic bullet, I'll disable install's use of
> matchpathcon for the upcoming test release.
> 
> Jim
> 
> In case you're interested in trying a recent snapshot,
> 
>   http://meyering.net/cu/coreutils-6.9-ss.tar.gz
>   http://meyering.net/cu/coreutils-6.9-ss.tar.gz.sig
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
