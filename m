Date: Sat, 23 Aug 2003 19:18:29 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: Russell Coker <russell@coker.com.au>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: general security lib (was: 2.6.0-test3)
Message-ID: <20030823091829.GA18656@snoopy.apana.org.au>
References: <1061468940.1665.16.camel@kusturica> <1061562771.28086.157.camel@moss-spartans.epoch.ncsc.mil> <3F465113.3010207@redhat.com> <200308231506.01495.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200308231506.01495.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, Aug 23, 2003 at 03:06:01PM +1000, Russell Coker wrote:
> As for login, I am under the impression that there is a possibility for a 
> dialog between application and PAM module, so the PAM module could specify 
> text to display and the application could return an answer to it.  But I 
> haven't done any PAM coding yet so I'm not sure of this.

I believe you are correct, the PAM module can ask any number of
questions which the application then has to ask. It is very flexible.
Perhaps too flexible, as it doesn't work well with fixed protocols
like the fixed password authentication protocol in sshd.

Last I heard, sshd had to be hacked to work with PAM, because the sshd
protocol doesn't support asking a undetermined number of questions as
required by PAM, in fact, the basic password authentication protocol
supports only one field: password.

IIRC, once the authentication has been done, then the PAM module can ask
any number of questions in wants. As sshd generates interactive prompts
at the server side to display on the client. eg. changing a expired
password after logging in via sshd works correctly via the PAM module.

So, I think it will work for this application, too.

I haven't looked at the sshd code though, so I am not sure of the
details. The situation may have improved over time, too.
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
