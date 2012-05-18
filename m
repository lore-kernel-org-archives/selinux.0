From: <ken.masumitsu@accenture.com>
To: <SELinux@tycho.nsa.gov>
Subject: fail to get seandroid code
Date: Fri, 18 May 2012 10:30:11 +0000
Message-ID: <4FB623F8.2060403@accenture.com>
Content-Type: text/plain; charset="iso-2022-jp"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

When I ran "repo sync" to install seandroid in reference to
http://selinuxproject.org/page/SEAndroid, I got an error like
---------------------------------------------------
Fetching projects: 10% (24/239) fatal:
http://selinuxproject.org/~seandroid/git/device/samsung/tuna/info/refs
not found: did you run git update-server-info on the server?
---------------------------------------------------

Though I checked the URL
(http://selinuxproject.org/~seandroid/git/device/samsung/tuna/info/refs)
by a browser, there is not such a directory.

Why the directory does not exist on the server?



________________________________
Subject to local law, communications with Accenture and its affiliates including telephone calls and emails (including content), may be monitored by our systems for the purposes of security and the assessment of internal compliance with Accenture policy.
______________________________________________________________________________________

www.accenture.com



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
