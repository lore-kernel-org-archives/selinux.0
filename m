Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1MMJdXI017889
	for <selinux@tycho.nsa.gov>; Thu, 22 Feb 2007 17:19:39 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1MMKvWA004209
	for <selinux@tycho.nsa.gov>; Thu, 22 Feb 2007 22:20:57 GMT
Message-ID: <45DE173F.2020201@mentalrootkit.com>
Date: Thu, 22 Feb 2007 17:20:47 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@mentalrootkit.com>, selinux@tycho.nsa.gov
Subject: Re: MITRE releases Polgen 1.4
References: <1169394672.10741.2.camel@zeroKnowledge>	<m2lkj8tdn2.fsf@dreaming.mitre.org>	<45CC87EE.9020407@mentalrootkit.com> <m2k5yrrpas.fsf@dreaming.mitre.org>
In-Reply-To: <m2k5yrrpas.fsf@dreaming.mitre.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Brian T. Sniffen wrote:
> Karl MacMillan <kmacmillan@mentalrootkit.com> writes:
> 
>> Brian T. Sniffen wrote:
>>> Polgen handles the modularity of reference policy by searching through
>>> .if files to find interfaces that will handle access requirements of
>>> the program under analysis.  The technique used appears complementary
>>> to Karl MacMillan's Madison library.
>> Can you point me to the implementation inside of polgen? It would seem
>> to be nice to merge this functionality into a single upstream
>> implementation. Do you have any interest in pursuing this?
> 
> Absolutely.  The implementor, David Harris, is out on leave
> for the next few weeks.  I believe the analogous code is in
> polgen/src/patterns/{extract_ifs,refpol}.py.  We don't do everything
> Sepolgen does, but we do generate new types.  I'd love to see these
> capabilities merged.
> 

The easiest short term solution may be for you to use the generated 
information about interface vectors from sepolgen-ifgen. That is 
currently stored in /usr/share/sepolgen/interface_info, but will be 
moving to /var to support read-only /usr.

That file has information about each interface in the form of:

[InterfaceVector files_read_etc_files $1:source ]
$1,etc_t,lnk_file,read,getattr
$1,etc_t,file,read,lock,getattr,ioctl
$1,etc_t,dir,getattr,search,read,lock,ioctl

So a header - keyword, name, parameters (including whether it is used as 
a source, target, object class, or perm). The access vectors in the form 
of source_type,target_type,object_class,perms. You could feed this 
information straight into your current interface selection algorithm.

Alternatively, you can also use the interface selection algorithm. It 
already works pretty well (including using information flow information 
to select interfaces closer to the requested access). I'd welcome help 
making this better.

Karl

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
