Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8BMguO3001877
	for <selinux@tycho.nsa.gov>; Mon, 11 Sep 2006 18:42:57 -0400
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8BMg4V8018499
	for <selinux@tycho.nsa.gov>; Mon, 11 Sep 2006 22:42:06 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: KaiGai Kohei <kaigai@kaigai.gr.jp>
Subject: Re: [RFC] SELinux and PostgreSQL (draft v2)
Date: Tue, 12 Sep 2006 08:42:42 +1000
Cc: selinux@tycho.nsa.gov, jbrindle@tresys.com
References: <44FFEB42.90203@kaigai.gr.jp> <200609101708.03454.russell@coker.com.au> <45055236.5010500@kaigai.gr.jp>
In-Reply-To: <45055236.5010500@kaigai.gr.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-2022-jp"
Message-Id: <200609120842.45760.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 11 September 2006 22:10, KaiGai Kohei <kaigai@kaigai.gr.jp> wrote:
> > Maybe the column object class could have an entry deletefrom which allows
> > deleting a row that has an entry in that column.
>
> It will solve the matter from TE viewpoint, but how dose it handle
> the MLS/MCS constraint?
> If the client must dominate any columns when a row is deleted, it seems
> to me that the client must have the highest or upper clearance originally.

Note that SE Linux has a flexible implementation of MLS that is under the 
control of policy.

So it's not a case of "delete is write and therefore a high confidentiality 
process can't do it", it's something we can control by policy.  We can write 
policy that doesn't have a mlsconstraint to restrict the deletefrom 
operation, or that has some specific domain attribute to permit it.

Also currently the shadow password file has level s0 in MLS policy as 
protecting it is considered an issue of system integrity not confidentiality.  
A password column in a database might have the same requirements.

-- 
http://etbe.blogspot.com/          My Blog
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
