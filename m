Subject: Re: Error in installing RefPolicy possibly some conflict?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: JanuGerman <doublemalam@yahoo.co.uk>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <20070327133530.47573.qmail@web86904.mail.ukl.yahoo.com>
References: <20070327133530.47573.qmail@web86904.mail.ukl.yahoo.com>
Content-Type: text/plain
Date: Tue, 27 Mar 2007 09:47:50 -0400
Message-Id: <1175003270.3864.309.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-03-27 at 14:35 +0100, JanuGerman wrote:
> Hi Every one,
> 
> I am getting the following error message, while trying
> to install Refpolicy. If some one can help me, prior
> to this, i installed refpolicy, but at startup, the
> system hanged. The output is trancated, and only the
> final part, which creates the problem is copied here
> for reference purposes.

What distribution are you using as your base?  The distributions that
have SELinux support (Debian, Fedora, Gentoo, RHEL) already include
reference policy, so you don't need to rebuild it from scratch unless
you are making major changes.

Did you just use the defaults for policy/modules.conf (i.e. generated
via make conf) and for build.conf settings?  In the latter case, you
need to set the build.conf settings appropriately whether by editing
that file or by specifying new values on the make command line. 

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
