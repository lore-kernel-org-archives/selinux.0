Subject: Re: Configuring kernel module for labeling ...
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: jsingh@ensim.com
Cc: nsa <SELinux@tycho.nsa.gov>
In-Reply-To: <1099427580.12614.15.camel@jsingh>
References: <1099385154.11681.3.camel@jsingh>
	 <200411030323.16648.russell@coker.com.au>
	 <1099417545.12370.21.camel@jsingh>
	 <1099420134.31739.250.camel@moss-spartans.epoch.ncsc.mil>
	 <1099420972.31739.269.camel@moss-spartans.epoch.ncsc.mil>
	 <1099427580.12614.15.camel@jsingh>
Content-Type: text/plain
Message-Id: <1099428529.31739.303.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 02 Nov 2004 15:48:49 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-11-02 at 15:33, Jaspreet Singh wrote:
> Can you provide me with some documents/links .. so that i can learn
> these things ... with details.

Documentation on SELinux kernel internals is rather out-of-date, I'm
afraid.  Need to update the SELinux module technical report
(http://www.nsa.gov/selinux/papers/module-abs.cfm, sources included in
the selinux-doc tarball) to reflect the current implementation, which
has changed a lot since it was written.  It would also be nice to have
an equivalent to http://www.nsa.gov/selinux/papers/slinux-abs.cfm for
the current implementation; that report was written for the original
SELinux kernel patch prior to LSM.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
