Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBSHlYvv004319
	for <selinux@tycho.nsa.gov>; Fri, 28 Dec 2007 12:47:34 -0500
Received: from an-out-0708.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id lBSHlXOt007703
	for <selinux@tycho.nsa.gov>; Fri, 28 Dec 2007 17:47:33 GMT
Received: by an-out-0708.google.com with SMTP id c38so749417ana.75
        for <selinux@tycho.nsa.gov>; Fri, 28 Dec 2007 09:47:30 -0800 (PST)
Cc: selinux@tycho.nsa.gov
Message-Id: <3532FDDB-FCA1-4A24-A9D1-D715ACA4960E@spitzner.net>
From: Lance Spitzner <lance@spitzner.net>
To: Dave Quigley <dpquigl@tycho.nsa.gov>
In-Reply-To: <1198862268.3451.109.camel@moss-terrapins.epoch.ncsc.mil>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: What happened to source for targeted?
Date: Fri, 28 Dec 2007 11:47:27 -0600
References: <705BD06B-DED9-4B3C-968C-4B8A09B97204@spitzner.net> <1198856247.3451.104.camel@moss-terrapins.epoch.ncsc.mil> <89CFFC9A-B0BC-4562-87F2-53CD208C9782@spitzner.net> <1198862268.3451.109.camel@moss-terrapins.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>>   http://docs.fedoraproject.org/selinux-faq-fc5/#faq-entry-whatis-refpolicy
>>
>> However, this is based on Fedora Core 5 which was last updated in in
>> 2006. Is this still the same SELinux that is shipped with Fedora8/
>> CentOS5?
>
> Exactly what kind of information are you looking for? Are you looking
> for an explanation of what SELinux is and the model it uses? Are you
> looking for guides on writing policy?

More along the lines of modifying policies.  I think what RH has done  
with Targeted is great, a good starting place that works for many  
situations.  What I'm looking for is current documentation on tweaking  
it.  I like the URL I give above, I just want to be sure its current.   
My only other concern with the documentation is they often reference  
the GUI tools, my preference is to do everything CLI.

Once again, thanks!

lance

PS: The other source I've found to be the most helpful in modifying/ 
updating SELinux is

  http://www.redhat.com/docs/manuals/enterprise/RHEL-5-manual/Deployment_Guide-en-US/sec-sel-policy-customizing.html

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
