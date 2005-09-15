Message-ID: <4328DABC.6040102@redhat.com>
Date: Wed, 14 Sep 2005 22:21:48 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>, fedora-announce@redhat.com,
   Fedora-SELinux-List@redhat.com
Subject: Introducing Multi-Category Security (MCS) SELinux policy in Rawhide
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Tonights rawhide update for selinux-policy-targeted and selinux-policy-strict include MCS.

What is MCS?

Multi-category Security (MCS) is a discretionary labeling mechanism for 
SELinux.  It allows users to add meaningful security labels to their own 
files.  Only domains with access to these labels will then be able to 
access the files.  Examples of category labels are "Company Confidential", 
"Intranet Only" and "Patient Records".

MCS can only further restrict access to files, after Unix DAC rules and 
SELinux MAC Type Enforcement rules have been applied. MCS uses much of the 
Multi-level Security (MLS) technology present in SELinux, but is designed 
to be simpler and map more readily to general use.

The general idea is to provide end users with more control over the 
security of their own files and help make SELinux more user-oriented.  In 
the future, we expect to make use of category labels in areas such as 
labeled printing, where the category label is printed on each page.

A reboot is required to turn on the MLS/MCS field on policy.  The goal was to allow everything
to continue working without the reboot.  A relabel should not be necessary.

Dan


-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
