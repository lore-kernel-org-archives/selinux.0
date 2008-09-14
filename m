Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8E4TWs4003492
	for <selinux@tycho.nsa.gov>; Sun, 14 Sep 2008 00:29:32 -0400
Received: from mail.asahi-net.or.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8E4SiMd013832
	for <selinux@tycho.nsa.gov>; Sun, 14 Sep 2008 04:28:45 GMT
Message-ID: <48CC931C.5000309@kaigai.gr.jp>
Date: Sun, 14 Sep 2008 13:29:16 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
CC: Toshiharu Harada <haradats@nttdata.co.jp>
Subject: [OT] voice at SecureOS BoF : Japan Linux Conference 2008
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

At the last Thursday, we had a BoF session titled as "Let's talk about secure
operating system" with TOMOYO Linux folks (Harada-san) at the Japan Linux
Conference 2008.

About 30-40 audiences were here, and most of them were "geek" of Linux but
not specialists for secure operating system. The purpose of this session is
to collect their opinion or complaint, and to feedback it to the upstreamed
community.

Fortunately, we could have an active discussion, and get well suggestive
opinions. I like to introduce them to share.

* Is SELinux hard to understand now?
- Selectable options are too many, we have to learn many things.
  - Existing "rwx" policy is not fine-grained, but so simple
    and small number of options enough to remind.
  - I want several grade of policy, like "gold policy", "silver policy", ...
    - For example, "silver policy" protect Web server only, "gold policy"
      protect Web and DNS/DBMS server, and so on.
- Information/documents are legacy and not enough.
  - Even if we have enough information/documents, too much things to be
    learned will prevent our motivation to utilize SELinux.
  - Documentations are written from the viewpoint of SELinux.
    It is a long way round to solve a trouble to set up administrators
    who tries to set up their application.
- No one mentioned about complexity of raw security policy.

* Now do we have a "killer application"?
- We cannot justify worker-hours to config SELinux without something
  attractive bigger than its cost.
  - There is no "killer application".
  - I had heard similar ones. "It is a secure platform, it is thought as
    complex one, it has no killer application". It looks like IPv6.
    - In other conference, most of people answered "Yes" for a question of
      "I'll move to IPv6, if YouTube is provided only IPv6.".
      Thus, something attractive helps people learn and use SELinux.
- Horses need carrots to run. SELinux does not provide us carrot yet.

* Misc topics
- Security is wide concept. Could you make it clear what SELinux can achieve
  and cannot?
  - Indeed, access controls are a part of security.
  - ISO/IEC15408 is a well organized list of security functionalities.
  - Naming is bad. "secure os" is confusable.
    - "mandatory access control os (Mac OS)" is more confusable. :)
- Are you need secure operating system? I asked at the last.
  -> Most of audience agreed.

----
* Moderator's impression

- The default configuration of SELinux got progressed for a few year's.
  Not negligible number of audiences answered that I'm using SELinux,
  because it is the default configuration.
  However, they are hard to find where to be customized, when he tries
  to start changing the default configuration.
  It might be necessary to limit user's selectable options in same time.
  For example, system-config-selinux shows list of all booleans. But it
  is too many to choice. Here was an opinion that per-application grouping
  and hierarchization of interface can help the situation.

- For documentations, I introduced Justin Mattock's efforts, and should
  be translated to Japanese or other languages.
  In addition, I thought per-application guidance is necessary,
  like "(Samba|Apache|xxxx) set up guide with SELinux".

- A killer application in SELinux is really really really necessary.

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
