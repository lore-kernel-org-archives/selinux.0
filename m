From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Brian May <bam@snoopy.apana.org.au>, SELinux@tycho.nsa.gov
Subject: Re: selinux from user POV
Date: Sun, 12 Oct 2003 19:01:27 +1000
References: <sf880644.030@atlas.snu.edu> <200310121309.27854.russell@coker.com.au> <20031012052756.GB28033@snoopy.apana.org.au>
In-Reply-To: <20031012052756.GB28033@snoopy.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200310121901.27362.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 12 Oct 2003 15:27, Brian May wrote:
> On Sun, Oct 12, 2003 at 01:09:27PM +1000, Russell Coker wrote:
> > > 2. Could give users access to a limited setfiles script with a limited
> > > read-only file_contexts file that they can use on their own
> > > directories,
> >
> > Why make it read-only?  If they want to copy the file_contexts file and
> > make changes then it's their issue.
>
> ... because for the general case, a user could assign any file to any
> type, and violate the system security policy (eg. a paranoid(?) security
> policy might include something along the lines of "users must not be
> allowed to view/execute files downloaded with Mozilla until after they
> are scanned with a virus scanner; this wouldn't work if users had full
> control over their file types).

So we make the policy only allow relabelto/from operations as suits our 
security goals.  In the example you give if you allow relabel from the type 
Mozilla uses to the regular type then you will lose if you allow creation of 
arbitary files/directories under the home directory.  But if you don't allow 
creation of arbitary file names then you have a problem which can easily be 
solved by file_type_auto_trans().

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
