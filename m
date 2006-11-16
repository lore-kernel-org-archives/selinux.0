Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAGHCYuB031505
	for <selinux@tycho.nsa.gov>; Thu, 16 Nov 2006 12:12:34 -0500
Received: from wr-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kAGHBoHF002702
	for <selinux@tycho.nsa.gov>; Thu, 16 Nov 2006 17:11:51 GMT
Received: by wr-out-0506.google.com with SMTP id 57so182683wri
        for <selinux@tycho.nsa.gov>; Thu, 16 Nov 2006 09:12:43 -0800 (PST)
Message-ID: <e294b46e0611160912t54e0e41k3325786bc4b04d79@mail.gmail.com>
Date: Thu, 16 Nov 2006 17:12:41 +0000
From: "Bradley Chapman" <kakadu@gmail.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: Strange file context issues
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1163687352.7374.39.camel@sgc.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <e294b46e0611160537p10c3224cmfecac57ac4c1f4bc@mail.gmail.com>
	 <1163686348.7374.37.camel@sgc.columbia.tresys.com>
	 <e294b46e0611160618xecaa0d9j48c47e9658cc44e5@mail.gmail.com>
	 <1163687352.7374.39.camel@sgc.columbia.tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Mr. PeBenito,

On 11/16/06, Christopher J. PeBenito <cpebenito@tresys.com> wrote:
> On Thu, 2006-11-16 at 14:18 +0000, Bradley Chapman wrote:
> > On 11/16/06, Christopher J. PeBenito <cpebenito@tresys.com> wrote:
> > > Are you using udev?  If you have udev and static device nodes under them
> > > on the regular fs, those are probably mislabeled.  Anything trying to
> > > use them early in the boot process before udev is started would hit
> > > denials like this.  Relabeling wouldn't get them since they're covered
> > > up by udev's tmpfs.  You'd have to unmount the tmpfs to relabel them.
> >
> > Ahhhh. All is made clear now. I am indeed using udev on this machine.
> > Would it be best to turn it off, or easier to simply switch to
> > runlevel 1 and do a relabel of the root filesystem?
>
> I would just do the latter.

Which is what I did. Thanks!

Brad
-- 
CONTROL YOUR TABS: https://addons.mozilla.org/extensions/158

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
