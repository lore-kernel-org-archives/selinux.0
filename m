Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n0GHhXbv012703
	for <selinux@tycho.nsa.gov>; Fri, 16 Jan 2009 12:43:33 -0500
Received: from yw-out-1718.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n0GHhWN9027046
	for <selinux@tycho.nsa.gov>; Fri, 16 Jan 2009 17:43:32 GMT
Received: by yw-out-1718.google.com with SMTP id 6so708206ywa.84
        for <selinux@tycho.nsa.gov>; Fri, 16 Jan 2009 09:43:31 -0800 (PST)
Message-ID: <5ab9a20b0901160943o14c1d47csbc763ae31564b97b@mail.gmail.com>
Date: Fri, 16 Jan 2009 12:43:31 -0500
From: "Cheyenne Solo" <ayla.cheyenne@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Base module, modules.conf
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_315367_14924833.1232127811196"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_315367_14924833.1232127811196
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello list,

This is my first time writing to the list, and I'm an SELinux newbie.

I'm trying to do some experiments on SELinux that require me to replace the
base module. I have a policy I want to use in its place, but I'm having
trouble on a couple different fronts. The easiest way I can think of to
change the base module is to redefine what makes it up--that is, modify the
modules.conf file. Neither of the makefiles have any conf target, however,
and I have been unable to generate it. I would also like to know how to
generate a base module from scratch.

So my question is: how do I create a base module? How is it different from
regular policy modules? How can I generate the modules.conf file and use it
to modify the base? I have found very little on this in any book or on the
Internet.

Relevant system stats: Fedora 8 running the targeted reference policy.

Thanks,
Ayla

------=_Part_315367_14924833.1232127811196
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello list,<br><br>This is my first time writing to the list, and I&#39;m an SELinux newbie.<br><br>I&#39;m trying to do some experiments on SELinux that require me to replace the base module. I have a policy I want to use in its place, but I&#39;m having trouble on a couple different fronts. The easiest way I can think of to change the base module is to redefine what makes it up--that is, modify the modules.conf file. Neither of the makefiles have any conf target, however, and I have been unable to generate it. I would also like to know how to generate a base module from scratch. <br>
<br>So my question is: how do I create a base module? How is it different from regular policy modules? How can I generate the modules.conf file and use it to modify the base? I have found very little on this in any book or on the Internet.<br>
<br>Relevant system stats: Fedora 8 running the targeted reference policy.<br><br>Thanks,<br>Ayla<br>
<br>

------=_Part_315367_14924833.1232127811196--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
