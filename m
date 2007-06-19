Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5JGYUqc023297
	for <selinux@tycho.nsa.gov>; Tue, 19 Jun 2007 12:34:30 -0400
Received: from dmzmta103.na.baesystems.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l5JGYTZO010908
	for <selinux@tycho.nsa.gov>; Tue, 19 Jun 2007 16:34:30 GMT
Received: from BLUMS0033.bluelnk.net (blums0033.bluelnk.net [10.40.96.54])
	by dmzmta103.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id l5JGY8bC006052
	for <selinux@tycho.nsa.gov>; Tue, 19 Jun 2007 12:34:08 -0400
Received: from blums0008.bluelnk.net (blums0008.sd.gd.com [134.120.81.40])
	by usdmta002.na.baesystems.com (Switch-3.2.0/Switch-3.2.0) with ESMTP id l5JGYIMv031565
	for <selinux@tycho.nsa.gov>; Tue, 19 Jun 2007 12:34:21 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: problem setting the security context of directories vs files
Date: Tue, 19 Jun 2007 09:34:24 -0700
Message-ID: <FB39F4E77226B448BC1388D3BE4E00CD01DBF7FE@blums0008.bluelnk.net>
From: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm having trouble setting the security context of directories using
file contexts. It seems to be working fine for files, but not
directories.

I have a module named import. Here is a copy of my import.fc file:

/m2ds/import	--	gen_context(system_u:object_r:import_dir_t,s0)
/m2ds/import/datasources	--
gen_context(system_u:object_r:import_dir_t,s0)
/m2ds/import/stage	--
gen_context(system_u:object_r:import_stage_t,s0)
/m2ds/import/junk	--
gen_context(system_u:object_r:import_dir_t,s0)
/home/m2/SimulatedImport/bin/SimulatedImport	--
gen_context(system_u:object_r:import_exec_t,s0)
/home/m2/SimulatedImport/bin/SimulatedImport_Server	--
gen_context(system_u:object_r:import_exec_t,s0)



"/m2ds/import" is a directory.
"/m2ds/import/datasources" is a directory.
"/m2ds/import/junk" is a file.

In the /m2ds directory, I do the following sequence of commands: 

> restorecon -R import
> ls -dZ import
drwxr-xr-x  root root system_u:object_r:default_t:SystemLow import
> cd import
> ls -Z
drwxr-xr-x  root root system_u:object_r:default_t:SystemLow datasources
-rw-r--r--  root root system_u:object_r:import_dir_t:SystemLow junk
drwxr-x---  root root system_u:object_r:default_t:SystemLow stage

As can be seen from the output above, the "/m2ds/import/junk" file has a
type of import_dir_t as specified in the file context file. But the
"/m2ds/import", "/m2ds/import/datasources", and "/m2ds/import/stage"
directories all have the default_t type, instead of the types specified
in the file context file.

Am I doing something wrong?



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
