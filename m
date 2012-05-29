Subject: RE: local_mainfest.xml
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Radzykewycz, T (Radzy)" <radzy@windriver.com>
Cc: William Roberts <bill.c.roberts@gmail.com>,
        "selinux@tycho.nsa.gov"
 <selinux@tycho.nsa.gov>,
        "seandroid@tycho.nsa.gov" <seandroid@tycho.nsa.gov>
In-Reply-To: <1337632361.28413.183.camel@moss-pluto>
References: 
	 <CAFftDdp7eW0swem7kMD589eQm6LT4pN5yf4-at9wMv1T9wY9rQ@mail.gmail.com>
	 ,<1337622828.28413.106.camel@moss-pluto>
	 <33006C99F5A5194A9B7A7715DFA3E3836504B4AA@ALA-MBB.corp.ad.wrs.com>
	 <1337632361.28413.183.camel@moss-pluto>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 29 May 2012 16:01:48 -0400
Message-ID: <1338321708.17627.169.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2012-05-21 at 16:32 -0400, Stephen Smalley wrote:
> On Mon, 2012-05-21 at 18:17 +0000, Radzykewycz, T (Radzy) wrote:
> > Sounds like a good organization to me.
> > 
> > You might want to name the branches similar to what AOSP uses, but mayme with "se" or "se_" prepended.  E.g. se_android-4.0.3_r1 instead of seandroid-4.0.3
> > 
> > In the past, there were times I would have liked the history, but I don't need it now.
> 
> Just to clarify: The reason for using e.g. seandroid-4.0.3 rather than
> seandroid-4.0.3_r1 in our other projects is that seandroid-4.0.3 is a
> branch rather than a tag.  Thus, we can keep back-porting changes from
> our master branch as well as merging subsequent releases of 4.0.3 (e.g.
> going to android-4.0.3_r1.1).  The local_manifest.xml file then just
> refers to seandroid-4.0.3 and doesn't need to be changed each time.
> 
> So I think we'll just use consistent names with our existing branches in
> other projects; the local_manifest.xml file on the seandroid-4.0.3
> branch will refer to the seandroid-4.0.3 branches of the other projects.

This repository has been created; you can clone it via:
git clone git://git.selinuxproject.org/~seandroid/manifests

There are three branches available: master, seandroid-4.0.3, and
seandroid-4.0.4.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
