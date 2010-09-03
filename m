Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o83LVXv0022104
	for <selinux@tycho.nsa.gov>; Fri, 3 Sep 2010 17:31:33 -0400
Received: from exprod8og106.obsmtp.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id o83LVVoP013284
	for <selinux@tycho.nsa.gov>; Fri, 3 Sep 2010 21:31:32 GMT
Received: by vws10 with SMTP id 10so2328205vws.17
        for <selinux@tycho.nsa.gov>; Fri, 03 Sep 2010 14:31:30 -0700 (PDT)
MIME-Version: 1.0
From: Jason Axelson <jaxelson@referentia.com>
Date: Fri, 3 Sep 2010 11:31:10 -1000
Message-ID: <AANLkTinseSQrjX7QoLo8wxh_HX6o_nKDUOeiN4-FvZBy@mail.gmail.com>
Subject: What is the risk of allowing audit_write?
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I have a bash script that I've written that runs in its own domain,
let's call it my_domain_t. When I run this script, I get a denial
stating that the script was denied audit_write. But all the script is
doing when it gets this denial is printing to the screen and asking
for user input.

>From the SELinux wiki I know that audit_write allows the program to
"send audit messsages from user space". But does that mean it is able
to write to /var/log/audit/audit.log? Or more likely send a message to
the audit daemon which then appends to the audit log?

So given that I currently don't feel any need to audit the results of
my script should I use an allow rule or something like dontaudit?

allow my_domain_t self:capability audit_write
or
dontaudit my_domain_t self:capability audit_write

I'm running this script on CLIP.

Thanks,
Jason

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
