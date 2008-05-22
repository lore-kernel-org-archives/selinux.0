Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m4MKGsrb012665
	for <selinux@tycho.nsa.gov>; Thu, 22 May 2008 16:16:54 -0400
Received: from dmzmta102.na.baesystems.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m4MKGqF0027835
	for <selinux@tycho.nsa.gov>; Thu, 22 May 2008 20:16:53 GMT
Received: from BLUMS0033.bluelnk.net (blums0033.bluelnk.net [10.40.96.54])
	by dmzmta102.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m4MKFX2C015876
	for <selinux@tycho.nsa.gov>; Thu, 22 May 2008 16:15:35 -0400
Received: from blums0042.bluelnk.net ([134.120.81.54])
	by usdmta001.na.baesystems.com (Switch-3.2.0/Switch-3.2.0) with ESMTP id m4MKGjWl009995
	for <selinux@tycho.nsa.gov>; Thu, 22 May 2008 16:16:46 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: overriding home directory file contexts
Date: Thu, 22 May 2008 13:16:47 -0700
Message-ID: <0794F277152EF94AA637E3AECF5CB70FB9DD15@blums0042.bluelnk.net>
From: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


There seems to be a very strong preference by the policy to label files
and directories under a home directory to user_home_t. I would like to
override that for a particular directory structure.

I have the following directory with many other files and directories
below it:
/opt/home/oracle/product/10.2.0

Many of files are libraries, which I would like to label lib_t and
shlib_t. As a specific example I have the following two files:

# ls -Z /opt/home/oracle/product/10.2.0/lib32/libsql*
-r-xr-xr-x  oracle oinstall user_u:object_r:user_home_t:SystemLow
/opt/home/oracle/product/10.2.0/lib32/libsqlplusic.so
-r-xr-xr-x  oracle oinstall user_u:object_r:user_home_t:SystemLow
/opt/home/oracle/product/10.2.0/lib32/libsqlplus.so

If I add the following file context line to my policy without any regex
wildcard chars, it works. The libsqlplus.so file is properly labeled as
shlib_t.

/opt/home/oracle/product/10\.2\.0/lib32/libsqlplus\.so --
gen_context(system_u:object_r:shlib_t,__SYSTEMLOW__)

# ls -Z /opt/home/oracle/product/10.2.0/lib32/libsql*
-r-xr-xr-x  oracle oinstall user_u:object_r:user_home_t:SystemLow
/opt/home/oracle/product/10.2.0/lib32/libsqlplusic.so
-r-xr-xr-x  oracle oinstall system_u:object_r:shlib_t:SystemLow
/opt/home/oracle/product/10.2.0/lib32/libsqlplus.so

However, if I add any regex wildcard chars, the label reverts back to
the default user_home_t context. For example, with the following
modification to the above file context line:

/opt/home/oracle/product/10\.2\.0/lib32/libsqlplus.*\.so --
gen_context(system_u:object_r:shlib_t,__SYSTEMLOW__)

# ls -Z /opt/home/oracle/product/10.2.0/lib32/libsql*
-r-xr-xr-x  oracle oinstall user_u:object_r:user_home_t:SystemLow
/opt/home/oracle/product/10.2.0/lib32/libsqlplusic.so
-r-xr-xr-x  oracle oinstall user_u:object_r:user_home_t:SystemLow
/opt/home/oracle/product/10.2.0/lib32/libsqlplus.so

Being that this is a large directory structure with lots of files, I do
not want to have to label each one explicitly, without the use of regex
wildcards. 

My understanding is that the policy should apply the most specific file
context line. But that does not appear to be what is happening in this
case. Is there some way to override this strong preference to label
files under a home directory as user_home_t?

I'm using the rhel5.1 mls policy

Any help would be greatly appreciated.

Thanks,
  Mike



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
