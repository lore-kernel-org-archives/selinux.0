Content-Type: text/plain;
  charset="iso-8859-1"
From: Bill Laut <wlsel@verizon.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: Q on nonuniform "recvfrom" avc message
Date: Tue, 8 Jul 2003 16:04:44 -0400
Cc: SELinux@tycho.nsa.gov
References: <200307081224.41939.wlsel@verizon.net> <1057687509.12912.100.camel@moss-huskers.epoch.ncsc.mil>
In-Reply-To: <1057687509.12912.100.camel@moss-huskers.epoch.ncsc.mil>
MIME-Version: 1.0
Message-Id: <200307081604.44315.wlsel@verizon.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 08 July 2003 02:05 pm, Stephen Smalley wrote:
> On Tue, 2003-07-08 at 12:24, Bill Laut wrote:
> >
> > [...]
> >
> > Why is SELinux reporting that kjournald is trying to receive this packet?
> >  Is it because the violation occured in the kernel while kjournald
> > happened to be the currently executing process?  Or is SELinux telling me
> > that there's a possible Trojan/BO/whatever buried inside of kjournald?
>
> The former.   The avc_audit code simply tests current and current->pid
> and includes the corresponding process information in the audit message
> if they are non-zero.  Not useful in the case of 'recvfrom' or other
> checks performed on network input processing.
>

Upon reading your reply, it occured to me that one of my sentences could have 
been misunderstood.  When I speculated "... that there's a possible 
Trojan/BO/whatever buried inside of kjournald," I did not mean to suggest 
that SELinux has NSA "spyware" buried in it.  I was thinking of something 
else entirely unrelated to NSA while typing that sentence, and therefore 
didn't catch and filter out the inference before submitting the post.

To anyone at NSA who might have been offended at my sentence, I sincerely 
apologize for my faulty editing.  From a security perspective, SELinux is, 
imho, the greatest thing since sliced bread and all of the Linux community 
owes NSA a debt of gratitude for having nurtured it into fruition.

Thanks again for all of your help.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
