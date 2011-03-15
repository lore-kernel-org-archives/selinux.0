Subject: Re: libselinux version bump past 99
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
        SELinux List
 <selinux@tycho.nsa.gov>,
        Eamon Walsh <ewalsh@tycho.nsa.gov>
In-Reply-To: <201103152224.51076.russell@coker.com.au>
References: <4D76AD1C.8080901@tycho.nsa.gov>
	 <4D7EA42A.2030802@windriver.com>  <201103152224.51076.russell@coker.com.au>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 15 Mar 2011 08:13:44 -0400
Message-ID: <1300191224.17384.5.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2011-03-15 at 22:24 +1100, Russell Coker wrote:
> On Tue, 15 Mar 2011, Paul Gortmaker <paul.gortmaker@windriver.com> wrote:
> > On a related note, is there a reason why the shared objects don't
> > track a similar versioning number?    We came across a situation
> > where an internal update added a new dir for libs.   But note the
> > shared objects are hard coded to version 1,  and the old selinux
> > libs just happened to be found 1st.   Which leads to a cryptic
> > internal selinux error message like this:
> 
> So what's the plans for libselinux at the moment?  Are we going to get a .so 
> version change in the near future?
> 
> I'm trying to build version 2.0.98 on Debian and I get the following error 
> when going from 2.0.96.  If we are going to increase the .so version in the 
> near future then I won't bother trying to solve this right now.  Although from 
> a quick inspection of the code it doesn't seem likely that this will cause any 
> problems, it seems that selabelsublist should never have been exported and is 
> extremely unlikely to have been used.

I'm not aware of any plan to change the .so version of libselinux. It
looks like you are correct about selabelsublist.  We should likely add
a .map file for libselinux as with libsemanage and libsepol and
explicitly enumerate the exported symbols.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
