Date: Mon, 17 Feb 2003 12:54:00 +0100
From: Tom <tom@lemuria.org>
To: kayo <kayo@pyra.ca>
Cc: SELinux@tycho.nsa.gov
Subject: Re: user transparent encryption
Message-ID: <20030217125359.D3272@lemuria.org>
References: <1045448295.28041.15.camel@smeagol> <1045460612.1408.9.camel@smeagol>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1045460612.1408.9.camel@smeagol>; from kayo@pyra.ca on Sun, Feb 16, 2003 at 11:43:32PM -0600
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Feb 16, 2003 at 11:43:32PM -0600, kayo wrote:
> What I mean in a way creating a situation in which the admin could
> revolk an account or even delete the files but not be able to view the
> encrypted data. Maybe the entire users home directory. Could something
> like this be done at a kernel level. I am toying with the concept of
> absolute privacy for the systems users.

Obviously can't be done. If you do it at the kernel level, the sysadmin
can replace the kernel...

You can STORE data on a remote machine without the admin being able to
read it. Just encrypt it. But as soon as the key needs to be entered on
a machine where you can't trust the admin, it is potentially
compromised.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
