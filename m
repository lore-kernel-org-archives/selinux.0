Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qACMNf4k014872
	for <selinux@tycho.nsa.gov>; Mon, 12 Nov 2012 17:23:42 -0500
Message-ID: <50A176CE.8010509@schaufler-ca.com>
Date: Mon, 12 Nov 2012 14:23:10 -0800
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: David Quigley <dpquigl@davequigley.com>
CC: bfields@fieldses.org, trond.myklebust@netapp.com, sds@tycho.nsa.gov,
        linux-nfs@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: Labeled NFS [v5]
References: <1352700947-3915-1-git-send-email-dpquigl@davequigley.com>
In-Reply-To: <1352700947-3915-1-git-send-email-dpquigl@davequigley.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 11/11/2012 10:15 PM, David Quigley wrote:
> The NFSv4 working group has finally accepted Labeled NFS as part of the NFSv4.2
> specification and it has been decided that a reposting of the Labeled NFS code
> for inclusion into mainline was a good idea. The patches have been rebased onto
> v3.7-rc2 and have been tested against the SELinux testsuite with the only
> failures being for features not supported by NFS.

It's going to take a few days (I'm traveling among other issues)
before I can have the Smack project comments ready. They are coming.

If you have pointers to test suites you found especially helpful
I could sure use them.

Thank you.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
