Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k85GKLbh009187
	for <selinux@tycho.nsa.gov>; Tue, 5 Sep 2006 12:20:21 -0400
Received: from legolas.drinsama.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k85GJbN8001291
	for <selinux@tycho.nsa.gov>; Tue, 5 Sep 2006 16:19:38 GMT
Subject: Re: refpolicy updates from debian
From: Erich Schubert <erich@debian.org>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1157467072.3199.255.camel@sgc>
References: <1157161065.9799.28.camel@wintermute.xmldesign.de>
	 <1157394109.3199.234.camel@sgc>
	 <1157399016.4446.20.camel@wintermute.xmldesign.de>
	 <1157464940.3199.250.camel@sgc>
	 <1157466795.20129.1.camel@wintermute.xmldesign.de>
	 <1157467072.3199.255.camel@sgc>
Content-Type: text/plain; charset=ISO-8859-15
Date: Tue, 05 Sep 2006 18:19:38 +0200
Message-Id: <1157473178.20129.9.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
> +allow usbmodules_t usbmodules_var_lib_t:dir rw_dir_perms;
> +allow usbmodules_t usbmodules_var_lib_t:file create_file_perms;

r_ should be sufficient, yes. Sorry about that.

best regards,
Erich Schubert
-- 
    erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
           There are only 10 types of people in the world:           //\
           Those who understand binary and those who don't           V_/_
   Freund in der Not will nicht viel heißen; hilfreich möchte sich
    mancher erweisen. Aber die neidlos dein Glück dir gönnen, die
        darfst du wahrlich Freunde nennen. --- Paul von Heyse



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
