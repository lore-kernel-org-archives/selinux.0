From: Yuichi Nakamura <ynakam@gwu.edu>
To: ewalsh@tycho.nsa.gov
Cc: Stephen Smalley <sds@tycho.nsa.gov>, KaiGai Kohei
 <kaigai@kaigai.gr.jp>,
        russell@coker.com.au, selinux@tycho.nsa.gov
Message-ID: <dac2af32a29.456f2347@gwu.edu>
Date: Thu, 30 Nov 2006 18:30:31 +0900
MIME-Version: 1.0
Subject: Re: First argument of matchpathcon_filespec_add
In-Reply-To: <1164831337.2794.149.camel@moss-huskies.epoch.ncsc.mil>
References: <ddeda73453a4.456d4b0b@gwu.edu>
 <200611291923.30237.russell@coker.com.au>
 <456D799E.40105@kaigai.gr.jp>
 <1164813040.23019.147.camel@moss-spartans.epoch.ncsc.mil>
 <1164831337.2794.149.camel@moss-huskies.epoch.ncsc.mil>
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


----- Original Message -----
> On Wed, 2006-11-29 at 10:10 -0500, Stephen Smalley wrote:
> > I agree that it is a problem with the interface.  We could attempt to
> > address it in a similar manner to stat() handling, but the interface 
> is
> > likely to become obsolete once the new label lookup interfaces being
> > proposed by Eamon Walsh are adopted and setfiles is converted over to
> > using them.
> 
> That's correct, the new interface will not take the mode but instead a
> security class, such as chr_file, blk_file, etc.

Thanks for reply.
I will solve the problem by defining _FILE_OFFSET_BIT 64 only in setfiles.c
until new setfiles implementation appears.

Yuichi Nakamura

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
