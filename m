Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k061qcXf025218
	for <selinux@tycho.nsa.gov>; Thu, 5 Jan 2006 20:52:38 -0500 (EST)
Received: from smtp104.sbc.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k061paYO018626
	for <selinux@tycho.nsa.gov>; Fri, 6 Jan 2006 01:51:36 GMT
Mime-Version: 1.0 (Apple Message framework v746.2)
In-Reply-To: <1136473856.27632.399.camel@moss-spartans.epoch.ncsc.mil>
References: <200601021906.k02J6HmB009362@luminouswebdesign.com> <1136303210.27632.65.camel@moss-spartans.epoch.ncsc.mil> <20060105145636.GB23146@sergelap.austin.ibm.com> <1136473856.27632.399.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <66DEEE25-FDF7-42CE-95FC-AAD4BE061C26@nall.com>
From: Joe Nall <joe@nall.com>
Subject: Re: SELinux metadata protection
Date: Thu, 5 Jan 2006 19:52:33 -0600
To: SE-Linux <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Jan 5, 2006, at 9:10 AM, Stephen Smalley wrote:

> On Thu, 2006-01-05 at 08:56 -0600, Serge E. Hallyn wrote:
>> Looking at the second "application note" for 5.3.4.1 of PP_MLOSPP_MR
>> (from http://niap.nist.gov/cc-scheme/pp/PP_MLOSPP-MR_V1.22.html), it
>> says:
>>
>> "The MAC policy covers all subjects and all objects.  The list of
>> objects must include object attributes that are themselves objects
>> (such as filenames) because they can be manipulated by a user."

In the paper world, classified documents routinely have unclassified
(or less classified) titles and metadata. In the trusted OS I use
regularly (HP CMW), a classified file can only be written to a lower
level directory by way of elevated privilege because the process
is 'writing down' to the directory and declaring the metadata to be
classified at the directory level. (C)overt channels are dealt with
during the evaluation of the use of privilege by the application.

joe

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
