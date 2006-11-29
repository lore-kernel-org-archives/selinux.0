Subject: Re: First argument of matchpathcon_filespec_add
From: Stephen Smalley <sds@tycho.nsa.gov>
To: KaiGai Kohei <kaigai@kaigai.gr.jp>
Cc: russell@coker.com.au, Yuichi Nakamura <ynakam@gwu.edu>,
        selinux@tycho.nsa.gov, Eamon Walsh <ewalsh@tycho.nsa.gov>
In-Reply-To: <456D799E.40105@kaigai.gr.jp>
References: <ddeda73453a4.456d4b0b@gwu.edu>
	 <200611291923.30237.russell@coker.com.au>  <456D799E.40105@kaigai.gr.jp>
Content-Type: text/plain
Date: Wed, 29 Nov 2006 10:10:40 -0500
Message-Id: <1164813040.23019.147.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-11-29 at 21:14 +0900, KaiGai Kohei wrote:
> Russell Coker wrote:
> > On Wednesday 29 November 2006 10:55, Yuichi Nakamura <ynakam@gwu.edu> wrote:
> >> When we do not want to build busybox with -D_FILE_OFFSET_BIT=64,
> >> we have to rebuild libselinux.
> >>
> >> I think it is a problem.
> >>
> >> Does anyone have good idea ?
> > 
> > What harm does it do to build busybox with 64bit file offsets?  For system 
> > recovery I think that 64bit offsets are desirable.
> > 
> > For embedded systems I guess you could have both the same whichever option you 
> > choose.
> 
> I think this topic should not be about the configuration of busybox,
> be about the consistency of the libselinux interfaces.
> 
> Because the length of ino_t which is the first argument of the funciton
> depends on the definition of _FILE_OFFSET_BIT, we have a possibility to
> have different views on the interface of libselinux.
> It is not limited in busybox cases.
> 
> Is it appropriate way that the consistency of libselinux's interface
> depends on whether the application defines _FILE_OFFSET_BIT, or not?

I agree that it is a problem with the interface.  We could attempt to
address it in a similar manner to stat() handling, but the interface is
likely to become obsolete once the new label lookup interfaces being
proposed by Eamon Walsh are adopted and setfiles is converted over to
using them.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
