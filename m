Message-ID: <543D5FDB.7@tycho.nsa.gov>
Date: Tue, 14 Oct 2014 13:39:39 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: William Roberts <bill.c.roberts@gmail.com>
Subject: Re: fs_use_trans
References: <CAFftDdrTMJrq5P=+vkJeQ612Ndr5G-_qc5Ve10k1F2KJfQpZGA@mail.gmail.com>	<543D36DC.8060202@tycho.nsa.gov>
 <CAFftDdpSxAHnNKHG+TGVBdWz6uxt_RKeo_BMbQ5UtpB_Q=Bg1w@mail.gmail.com>
In-Reply-To: <CAFftDdpSxAHnNKHG+TGVBdWz6uxt_RKeo_BMbQ5UtpB_Q=Bg1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/14/2014 11:00 AM, William Roberts wrote:
> Yeah looking at this statement doesn't really just allow for the use of
> type_transition statements on that filesystem? It doesn't actually generate
> labels, you still need the typetrans rule. It appears that the definition
> is overreaching for its actual function and probably inferring something
> from refpolicy.

Each of the fs_use_* statements specifies how to determine the label for
existing inodes in the filesystem.  fs_use_xattr tells SELinux to fetch
the inode label via ->getxattr().  fs_use_task tells SELinux to assign
the inode the label of its creator.  fs_use_trans tells SELinux to
compute the inode label based on the result of security_transition_sid()
on the creating process SID and the filesystem SID.  What
security_transition_sid() returns depends on whether or not you have a
transition rule in policy.  So fs_use_trans doesn't guarantee that you
have a transition rule in place; it just allows you to use transition
rules if you wish to label the inodes based on some combination of the
creating process domain and the filesystem type.
