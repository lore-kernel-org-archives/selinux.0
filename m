Subject: Re: mcstransd
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200804071413.20072.russell@coker.com.au>
References: <200804071413.20072.russell@coker.com.au>
Content-Type: text/plain
Date: Mon, 07 Apr 2008 11:58:34 -0400
Message-Id: <1207583914.21223.29.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-04-07 at 15:13 +1100, Russell Coker wrote:
> Is there a plan for a mlstransd daemon?  If there is no plan for a different 
> daemon for translating MLS contexts then this should be renamed to senstransd 
> or something similar.

We're looking into getting the MITRE label encoding library released so
that it can be used as the core of a mlstransd.

> Also the man page mcs.8 (which incidentally needs the following patch) 
> probably belongs somewhere else.  We need a mls.8 as well, and a man page for 
> mcstransd (which I'll write soon).
> 
> --- mcstrans-0.2.7.orig/man/man8/mcs.8
> +++ mcstrans-0.2.7/man/man8/mcs.8
> @@ -20,7 +20,7 @@
>  Certain applications like printing and auditing will use these labels to
>  identify the files.  By setting a category on a file you will prevent
>  other applications/services from having access to the files.
> -.p
> +.P
>  Examples of file lables would be PatientRecord, CompanyConfidential etc.
> 
>  .SH "SEE ALSO"
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
