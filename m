Date: Sat, 23 Aug 2003 19:21:41 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: Russell Coker <russell@coker.com.au>
Cc: Magos?nyi ?rp?d <mag@bunuel.tii.matav.hu>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: general security lib (was: 2.6.0-test3)
Message-ID: <20030823092141.GB18656@snoopy.apana.org.au>
References: <1061555921.1648.142.camel@kusturica> <200308230009.19552.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200308230009.19552.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, Aug 23, 2003 at 12:09:19AM +1000, Russell Coker wrote:
> Theodore Ts'o suggested to me that a new PAM call be added to run the shell 
> which takes appropriate parameters about user-name etc.  Then a SE Linux 
> version of this module could change the security context appropriately, thus 
> requiring only one copy of the code to determine the context to use, and not 
> requiring any on-going modification to applications.

Would this work properly with the chroot authentication stuff in sshd?
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
