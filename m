Message-ID: <4C1F7006.5020207@bian-fu.net>
Date: Mon, 21 Jun 2010 15:58:30 +0200
From: Alice Mynona <alice_mynona@bian-fu.net>
MIME-Version: 1.0
To: SELinux@tycho.nsa.gov
Subject: Developing a SELinux policy for antivirus - Activating a boolean
 variable when another has been actived
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

during the developing of a SELinux module for an antivirus software an additional question arised:

There a two boolean variables named "boolean_a" and "boolean_b". The SELinux module should automatically set "boolean_a" to true, if "boolean_b" has been set to true an set it to false if "boolean_b" has been deactived. Is there a way to realize this?

Thanks in advance.

Best regards,
Alice

-- 
+ Alice Mynona
+ Email: Alice_Mynona@bian-fu.net





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
