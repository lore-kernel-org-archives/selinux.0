Subject: Re: Add a new class
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Park Lee <parklee_sel@yahoo.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <20050112194047.55536.qmail@web51509.mail.yahoo.com>
References: <20050112194047.55536.qmail@web51509.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1105565690.23136.22.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 12 Jan 2005 16:34:50 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-01-12 at 14:40, Park Lee wrote:
> Now, I'm using FC2. I try to add a new class ( also
> just for learing ).
> I've added a new class to security_classes and the
> permissions to access_vectors (In
> /etc/security/selinux/src/policy/flask), after that,
> rebuilt the headers with the Makefile in the flask
> directory and put them in
> /usr/src/linux-2.6.5-1.358/security/selinux/include as
> Joshua Brindle have mentioned. and then rebooted on
> the new kernel.
> After I rebooted on the new kernel, I went into
> /etc/security/selinux/src/policy, and ran 'make load'.
> But this time, the security_load_policy failed!
> The following is what appeared on my screen:

What messages did you get in /var/log/messages or dmesg output upon the
load?

Did you add the new class to the end of the current set of classes? 
Otherwise, it will perturb the values of the existing classes and the
kernel will refuse to load it after the initial policy load.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
