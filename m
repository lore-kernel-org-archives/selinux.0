Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4LJhLjD017983
	for <selinux@tycho.nsa.gov>; Mon, 21 May 2007 15:43:21 -0400
Received: from atlrel8.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4LJhJ9R018327
	for <selinux@tycho.nsa.gov>; Mon, 21 May 2007 19:43:19 GMT
From: Paul Moore <paul.moore@hp.com>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Fedora Core 7 has frozen and Fedora 8 Development has started
Date: Mon, 21 May 2007 15:43:09 -0400
Cc: Daniel J Walsh <dwalsh@redhat.com>, Klaus Weidner <klaus@atsec.com>
References: <464E13CB.1070609@redhat.com> <20070521190811.GA11544@w-m-p.com> <4651EFCC.1040500@redhat.com>
In-Reply-To: <4651EFCC.1040500@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705211543.10171.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday, May 21 2007 3:15:24 pm Daniel J Walsh wrote:
> Klaus Weidner wrote:
> > On Fri, May 18, 2007 at 04:59:55PM -0400, Daniel J Walsh wrote:
> >> This is a good time to get experimental code/updates into the rawhide
> >> stream.
> >
> > [...]
> >
> >> Others???
> >
> > I haven't seen MCS mentioned much recently, is anyone working on that at
> > this time? Back at the 2006 SELinux symposium there were plans to
> > integrate category support in file managers and maybe other user tools,
> > to make it more suitable for everyday use by non-experts.
> >
> > -Klaus
>
> We switched to using the entire context.  There has been some arguments
> over the value of
> MCS versus better support for Type Enforcement in general.

If I recall correctly, there was some chatter about creating a more generic 
translation facility so that we could translate the entire SELinux context, 
versus the MLS range which we do now, into a more human readable label.  I 
believe doing something like this would help achieve some of the goals that 
Klaus hinted at with the "make it more suitable for everyday use by 
non-experts".  It would also help to reinforce the notion that the context is 
a blob and in general shouldn't be parsed by applications that don't know 
what they are doing.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
