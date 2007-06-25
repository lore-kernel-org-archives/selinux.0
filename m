Subject: Re: mls contraints on adding files to directories
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Clarkson, Mike R (US SSA)" <mike.clarkson@baesystems.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <FB39F4E77226B448BC1388D3BE4E00CD01DBFA97@blums0008.bluelnk.net>
References: <FB39F4E77226B448BC1388D3BE4E00CD01DBFA97@blums0008.bluelnk.net>
Content-Type: text/plain
Date: Mon, 25 Jun 2007 15:19:41 -0400
Message-Id: <1182799181.5636.156.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-06-25 at 11:54 -0700, Clarkson, Mike R (US SSA) wrote:
> I think that I'm misunderstanding the mls constraints on adding files to
> directories. 
> 
> I thought that the following constraint would prevent adding a file at a
> higher security level than the directory, unless the domain of the
> writing process had been given the mlsfilewritetoclr attribute, or the
> directory type had been given the mlstrustedobject attribute:
> 
> mlsconstrain dir { add_name remove_name reparent rmdir }
> 	((( l1 dom l2 ) and ( l1 domby h2 )) or
> 	 (( t1 == mlsfilewritetoclr ) and ( h1 dom l2 ) and ( l1 domby
> l2 )) or
> 	 ( t1 == mlsfilewrite ) or
> 	 ( t2 == mlstrustedobject ));

(l1, h1) are the low and high levels of the process.
(l2, h2) are the low and high levels of the directory (usually the
same).

This is a constraint on a permission check between the process and the
parent directory.  The new file's label doesn't come into play at all in
this constraint.

> However, I can use runcon to create a file at a higher level than the
> directory. For example, I can do the following:
> 
> > runcon -l s3 touch /m2ds/import/datasources/inputBuffer/U/temp
> 
> > ls -Z /m2ds/import/datasources/inputBuffer/U/temp
> -rw-r--r--  root root root:object_r:import_datasources_t:s3
> /m2ds/import/datasources/inputBuffer/U/temp
> 
> > ls -dZ /m2ds/import/datasources/inputBuffer/U
> drwxrwxr-x  root m252 system_u:object_r:import_datasources_t:s1
> /m2ds/import/datasources/inputBuffer/U
> 
> I'm able to do this with the policy in Enforcing mode. 
> 
> So what is this mlsconstrain statement doing?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
