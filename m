Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8RGmTsJ006292
	for <selinux@tycho.nsa.gov>; Sat, 27 Sep 2003 12:48:29 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8RGkhZt003692
	for <selinux@tycho.nsa.gov>; Sat, 27 Sep 2003 16:46:43 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h8RGkhM3003689
	for <selinux@tycho.nsa.gov>; Sat, 27 Sep 2003 16:46:43 GMT
Subject: Re: unlabeled_t and assert.te
From: Howard Holm <hdholm@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SELinux Mailing List <selinux@tycho.nsa.gov>
In-Reply-To: <200309272054.50553.russell@coker.com.au>
References: <200309272054.50553.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1064681300.16303.21.camel@moss-huskies>
Mime-Version: 1.0
Date: 27 Sep 2003 12:48:20 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2003-09-27 at 06:54, Russell Coker wrote:
> I believe that although unlabeled_t often refers to files (probably it
> mostly refers to files) it has a special status and therefore does not
> deserve the file_type attribute.  So I have defined it as only having
> the sysadmfile attribute (to allow the administrator to fix problems),
> and I am considering giving it the "domain" attribute as well.

While I agree that it would be beneficial to have assertions to catch
stupid policy, I think your current solution has a serious drawback.  By
removing file_type from unlabeled_t you break the notion that file_type
includes all types on persistent media.  This means that existing rules
such as 

# Relabel all files.
allow $1_t file_type:dir { getattr read search relabelfrom relabelto };
allow $1_t file_type:file_class_set { getattr relabelfrom relabelto };

are no longer useful.  While you could change those to

allow $1_t sysadmfile:dir { getattr read search relabelfrom relabelto };
allow $1_t sysadmfile:file_class_set { getattr relabelfrom relabelto };

as you suggest, not all files on persistent media are labeled with
sysadmfile.  In particular, I believe a number of devices, the shadow
file, etc. don't have the sysadmfile attribute.  While sysadmfile may be
sufficient for relabeling most mistakes, it isn't sufficient to relabel
files when policy updates make dramatic changes or when switching to a
dramatically different policy.  It's true that doesn't happen often, and
such dramatic changes are usually made with enforcing (at least) off. 
Still, I don't think redefining the definition of file_type is the right
answer.  Maybe, as you suggest more fundamental changes are needed, but
that will require a lot more thought.

-- 
Howard Holm <hdholm@epoch.ncsc.mil>
Office of Defensive Computing Research
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
