Subject: Re: diffs + additions to NSA cvs policy
From: Erich Schubert <erich@debian.org>
To: SELinux@tycho.nsa.gov
In-Reply-To: <1135132579.5408.33.camel@wintermute.xmldesign.de>
References: <1135132579.5408.33.camel@wintermute.xmldesign.de>
Content-Type: text/plain
Date: Wed, 21 Dec 2005 15:43:55 +0100
Message-Id: <1135176236.23898.2.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
one more thing missing in the SELinux policy:
  portcon udp 1194 system_u:object_r:openvpn_port_t

1194 is the current default port for openvpn (official IANA assignment)
port 5000 is an old value, when it didn't have an IANA port yet.

best regards,
Erich Schubert
-- 
    erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
                 Friends are those who reach out for                 //\
                   your hand but touch your heart.                   V_/_
  Wer keine Zeit mehr mit echten Freunden verbringt, der wird bald
          sein Gleichgewicht verlieren. --- Michael Levine


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
