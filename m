Date: Sun, 12 Oct 2003 15:27:56 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: SELinux@tycho.nsa.gov
Subject: Re: selinux from user POV
Message-ID: <20031012052756.GB28033@snoopy.apana.org.au>
References: <sf880644.030@atlas.snu.edu> <200310121309.27854.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200310121309.27854.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Oct 12, 2003 at 01:09:27PM +1000, Russell Coker wrote:
> > 2. Could give users access to a limited setfiles script with a limited
> > read-only file_contexts file that they can use on their own directories,
> 
> Why make it read-only?  If they want to copy the file_contexts file and make 
> changes then it's their issue.

... because for the general case, a user could assign any file to any
type, and violate the system security policy (eg. a paranoid(?) security
policy might include something along the lines of "users must not be
allowed to view/execute files downloaded with Mozilla until after they
are scanned with a virus scanner; this wouldn't work if users had full
control over their file types).
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
