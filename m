Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k96KctjW008908
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 16:38:55 -0400
Received: from mail3.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k96KcIru009071
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 20:38:19 GMT
Date: Fri, 6 Oct 2006 16:38:54 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Chad Sellers <csellers@tresys.com>
cc: selinux@tycho.nsa.gov
Subject: Re: [PATCH 1/4] Bug fix in polidydb_destroy
In-Reply-To: <20061006201103.644565000@tresys.com>>
Message-ID: <Pine.LNX.4.64.0610061636280.7910@d.namei>
References: <20061006200951.006196000@tresys.com>> <20061006201103.644565000@tresys.com>>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 6 Oct 2006, Chad Sellers wrote:

> This patch fixes two bugs in policydb_destroy. Two list pointers (policydb.ocontexts[i] and policydb.genfs) were not being reset to NULL when the lists they pointed to were being freed. This caused a problem when the initial policy load failed, as the policydb being destroyed was not a temporary new policydb that was thrown away, but rather was the global (active) policydb. Consequently, later functions, particularly sys_bind->selinux_socket_bind->security_node_sid and do_rw_proc->selinux_sysctl->selinux_proc_get_sid->security_genfs_sid tried to dereference memory that had previously been freed.
> 
> Signed-off-by: Chad Sellers <csellers@tresys.com>

Applied to

git://git.infradead.org/~jmorris/selinux-2.6.git
http://git.infradead.org/?p=users/jmorris/selinux-2.6.git;a=summary


If the other patches look ok, I'll start feeding them into an 
selinux-2.6.20 tree.


In the future, please separate bugfixes from features, as well as 
justifying the text of the mail, and using subject lines per:

http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt




- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
