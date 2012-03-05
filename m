Subject: Re: SE Android and Finer Grained Permissions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: jwcart2@tycho.nsa.gov
Cc: noloader@gmail.com, SE Linux <SELinux@tycho.nsa.gov>
In-Reply-To: <1330960184.1841.17.camel@moss-lions.epoch.ncsc.mil>
References: 
	 <CAH8yC8kE6fEGijSyjz4_VrqoogbrqLAsHwCXsRQH3qd52e=kVw@mail.gmail.com>
	 <1330960184.1841.17.camel@moss-lions.epoch.ncsc.mil>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 05 Mar 2012 14:44:38 -0500
Message-ID: <1330976678.7184.8.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2012-03-05 at 10:09 -0500, James Carter wrote:
> On Sun, 2012-03-04 at 21:02 -0500, Jeffrey Walton wrote:
> > Hi All,
> > 
> > Forgive my ignorance here.....
> > 
> > I was reading the slides at on SE Android at
> > http://selinuxproject.org/~jmorris/lss2011_slides/caseforseandroid.pdf.
> > 
> > I see the slides point out "[Current Android suffers] limited
> > granularity, coarse-grained privilege." But I don't see where SE
> > Android corrected it. For example, it appears READ_PHONE_STATE still
> > encompasses reading a device serial number, IMEI, SIM ID, call state,
> > incoming calling number, etc.
> > 
> > Does SE Android remediate the coarse grained permissions?
> > 
> 
> No. Currently, the SE Android policy is only trying to ensure that the
> existing Android security model is enforced. The Android permissions
> work exactly the same way.
> 
> SE Android is still a work in progress. Our goal is to extend security
> controls into the application frameworks of Android to better control
> applications and that could eventually lead to finer-grained control
> over resources currently controlled by Android permissions.

Just to further clarify, SE Android does in fact address the limitations
of the kernel layer DAC security model, including overcoming its limited
granularity and coarse-grained privilege model (which is what you quoted
above from slide 5).  But addressing the application layer (aka
middleware layer) security model remains to be done, as noted on slide
46. Also, you may find the more recent talk we gave at the Android
Builders Summit to be helpful.  Links to the slides and video from that
talk are available on the wiki:
http://selinuxproject.org/page/SEAndroid#Presentations

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
