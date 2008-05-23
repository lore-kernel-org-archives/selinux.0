Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m4NIKifa025665
	for <selinux@tycho.nsa.gov>; Fri, 23 May 2008 14:20:44 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m4NIKiKd009065
	for <selinux@tycho.nsa.gov>; Fri, 23 May 2008 18:20:44 GMT
Message-ID: <48370B14.6080808@redhat.com>
Date: Fri, 23 May 2008 14:21:08 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
CC: selinux@tycho.nsa.gov
Subject: Re: overriding home directory file contexts
References: <0794F277152EF94AA637E3AECF5CB70FB9DD15@blums0042.bluelnk.net>
In-Reply-To: <0794F277152EF94AA637E3AECF5CB70FB9DD15@blums0042.bluelnk.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Clarkson, Mike R (US SSA) wrote:
> There seems to be a very strong preference by the policy to label files
> and directories under a home directory to user_home_t. I would like to
> override that for a particular directory structure.
> 
> I have the following directory with many other files and directories
> below it:
> /opt/home/oracle/product/10.2.0
> 
This sounds like a genhomedircon problem.  Unless you have a Human Being
named Oracle, this should not be labeled as a homedir.  Check the passwd
entry and make sure it has a shell of /sbin/nologin on /bin/false.

Then run genhomedircon

Now the labels of /opt/home  should not longer be set for a homedir.
You can relabel using restorecon.
> Many of files are libraries, which I would like to label lib_t and
> shlib_t. As a specific example I have the following two files:
> 
> # ls -Z /opt/home/oracle/product/10.2.0/lib32/libsql*
> -r-xr-xr-x  oracle oinstall user_u:object_r:user_home_t:SystemLow
> /opt/home/oracle/product/10.2.0/lib32/libsqlplusic.so
> -r-xr-xr-x  oracle oinstall user_u:object_r:user_home_t:SystemLow
> /opt/home/oracle/product/10.2.0/lib32/libsqlplus.so
> 
> If I add the following file context line to my policy without any regex
> wildcard chars, it works. The libsqlplus.so file is properly labeled as
> shlib_t.
> 
> /opt/home/oracle/product/10\.2\.0/lib32/libsqlplus\.so --
> gen_context(system_u:object_r:shlib_t,__SYSTEMLOW__)
> 
> # ls -Z /opt/home/oracle/product/10.2.0/lib32/libsql*
> -r-xr-xr-x  oracle oinstall user_u:object_r:user_home_t:SystemLow
> /opt/home/oracle/product/10.2.0/lib32/libsqlplusic.so
> -r-xr-xr-x  oracle oinstall system_u:object_r:shlib_t:SystemLow
> /opt/home/oracle/product/10.2.0/lib32/libsqlplus.so
> 
> However, if I add any regex wildcard chars, the label reverts back to
> the default user_home_t context. For example, with the following
> modification to the above file context line:
> 
> /opt/home/oracle/product/10\.2\.0/lib32/libsqlplus.*\.so --
> gen_context(system_u:object_r:shlib_t,__SYSTEMLOW__)
> 
> # ls -Z /opt/home/oracle/product/10.2.0/lib32/libsql*
> -r-xr-xr-x  oracle oinstall user_u:object_r:user_home_t:SystemLow
> /opt/home/oracle/product/10.2.0/lib32/libsqlplusic.so
> -r-xr-xr-x  oracle oinstall user_u:object_r:user_home_t:SystemLow
> /opt/home/oracle/product/10.2.0/lib32/libsqlplus.so
> 
> Being that this is a large directory structure with lots of files, I do
> not want to have to label each one explicitly, without the use of regex
> wildcards. 
> 
> My understanding is that the policy should apply the most specific file
> context line. But that does not appear to be what is happening in this
> case. Is there some way to override this strong preference to label
> files under a home directory as user_home_t?
> 
> I'm using the rhel5.1 mls policy
> 
> Any help would be greatly appreciated.
> 
> Thanks,
>   Mike
> 
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
