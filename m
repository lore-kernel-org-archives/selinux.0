Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6MHIvHa021024
	for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2003 13:18:57 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h6MHHpFB019447
	for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2003 17:17:51 GMT
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by jazzswing.ncsc.mil  with ESMTP id h6MHHpGD019444
	for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2003 17:17:51 GMT
Message-ID: <3F1D71F6.3080105@redhat.com>
Date: Tue, 22 Jul 2003 13:18:46 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joubert Berger <joubert@berger-family.org>
CC: selinux@tycho.nsa.gov
Subject: Re: Red Hat webcast on SELinux
References: <3F1C1B4D.6080102@redhat.com> <1058893583.7990.45.camel@localhost.localdomain>
In-Reply-To: <1058893583.7990.45.camel@localhost.localdomain>
Content-Type: multipart/alternative;
 boundary="------------050004030606070708080001"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------050004030606070708080001
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

*WebEx FAQ for Red Hat*

*Frequently asked questions about WebEx and Linux*


*What are the system requirements for using WebEx?
*Requirements for Linux users
Red Hat 8 with Mozilla 1.0.1 or later (set as default browser)

Red Hat 6 - 7.3 with Netscape 4.7

Note: Red Hat 9 has not been certified for this release, but may work 
with a clean installation.

Requirements for Windows users
Windows 95 - XP
Internet Explorer 4,5 or 6 or Netscape Navigator 4.7.x

*Can I use Netscape 7 or Mozilla to start or join a meeting?*
Yes. WebEx officially supports Mozilla 1.2.1. Netscape 7 and earlier 
versions of Mozilla should work as well.

*How do I set up my Linux computer to use WebEx?
*1. Go to your WebEx site
2. Click *Set Up* in the navigation bar, then click *Meeting Manager*.
3. Click *Download Installer* in the Set Up WebEx Meeting Manager page. *
*4. Click *OK* in the Downloading wbxsetup-moz.tar.gz dialog box.
4. Click *Save* in the Enter name of file to save to... dialog box.
5. Save the file in the root directory. (Do not change the name of the 
installer file.)
6. After downloading, open a terminal window and type the folowing 
commands (these instructions will be presented on screen):

    *tar xfz wbxsetup-moz.tar.gz*
    *cd WebExPkg*
    *./INSTALL *

7. Type 1 to select Install/Upgrade.
8. Type *n* to complete the installation without installing the WebEx X 
server extension. This is recommended for most users even to be a 
presenter and use desktop sharing.

If you have the root password, you can type *y* to install the WebEx X 
server extension, however this option is not recommended due to 
compatibility issues with Red Hat 8. This enables application and Web 
browser sharing. IMPORTANT: For Red Hat Linux 8.0, you must restart your 
computer after installing the X server extension.

*How can I share my desktop (and all applications) from Linux?*

1. In the WebEx Meeting Manager, click the *Share* menu and select 
*Desktop*.
2. Minimize the *Share Desktop* and *Meeting Manager* windows to view 
the current desktop.
3. To stop desktop sharing, close the *Share Desktop* window.

*Tip:* You can use one workspace for the Meeting Manager window then 
switch to another workspace to share applications. WebEx will always 
share the desktop of the workspace that is currently in view. The 
keyboard shortcut for switching workspaces is ctrl-alt-arrow.

*How can I share a specific application (e.g. OpenOffice) from Linux?
*Note: Installation of the Xshare extension is required for the 
presenter to use application sharing. This feature has known 
compatibility issues with Red Hat 8 and is not recommended for that release.

1. Start the application(s) that you want to share.
2. In the WebEx Meeting Manager, click the *Share* menu and select 
*Application*.
3. In the Share Application window that appears, click the *Sharing* 
menu and select *Share Application*, then select the application you 
want to share from the sub menu.
4. Minimize the *Share Application* and *Meeting Manager* windows to 
view the shared application on the current desktop.

To stop application sharing, close the *Share Application* window.

*What can I do if attendees cannot see exactly what I am sharing?*
Try screen sampling mode as follows:

1. Start Desktop sharing.
2. Click the *Sharing* menu in the Share Desktop window.
3. Select *Switch to... *then select *Screen Sampling Based*.

Note: Screen sampling mode may improve the appearance of your desktop on 
attendee's screens.

*What if I get disconnected from the meeting?*
No problem. Just go back to the Meeting Center home page and join again. 
If you were the host, be sure to log in first to retain the host role 
when you rejoin the meeting.

**What are the known issues and limitations* for WebEx on Linux?
** Application sharing may not work well with some applications. Switch 
to desktop sharing and use screen sampling mode.
* Presenters on Linux may not see chat from Attendees when the Attendee 
Priviliges are set to chat with host and presenter only.
* Integrated teleconferencing is not supported in this release. Use call 
in teleconferencing.
* Presentation or Document viewing and sharing are not supported in this 
release. Use desktop or application sharing.
* When sharing the desktop using screen sampling mode, attendees will 
not see the presenter's mouse pointer.

*Support and Feedback
*Click the *Assistance* link in the navigation bar on your Meeting 
Center site, then click *Support* to view the Support page.
Refer to the Support page to find information for technical support, a 
feedback form, release notes, downloads and more.

------------------------------------------------------------------------


Joubert Berger wrote:

>Just tried to sign up.  Can't.  They don't support RH9.  What's that all
>about?  Anyone know how I can get the WebEx Meeting Manager software?
>
>On Mon, 2003-07-21 at 12:56, Daniel J Walsh wrote:
>  
>
>>I will be giving a webcast talking about SELinux and Red Hat on July 22, 
>>2003.
>>
>>https://www.redhat.com//apps/webform.html?event_type=webcast&eid=225
>>
>>Dan
>>
>>
>>
>>--
>>This message was distributed to subscribers of the selinux mailing list.
>>If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>>the words "unsubscribe selinux" without quotes as the message.
>>
>>    
>>
>
>  
>

--------------050004030606070708080001
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <title></title>
</head>
<body>
<p><font face="Verdana, Arial, Helvetica, sans-serif"><b><font size="5">WebEx
FAQ for Red Hat</font></b></font></p>
<p><font face="Verdana, Arial, Helvetica, sans-serif"><b>Frequently
asked questions   about WebEx and Linux</b></font></p>
<p><br>
<b><font face="Arial, Helvetica, sans-serif">What are the system
requirements   for using WebEx?</font><br>
</b>Requirements for Linux users<br>
Red Hat 8 with Mozilla 1.0.1 or later (set as default browser)</p>
<p>Red Hat 6 - 7.3 with Netscape 4.7</p>
<p>Note: Red Hat 9 has not been certified for this release, but may
work with   a clean installation.<br>
</p>
<p>Requirements for Windows users<br>
Windows 95 &#8211; XP<br>
Internet Explorer 4,5 or 6 or Netscape Navigator 4.7.x <br>
</p>
<p><b><font face="Arial, Helvetica, sans-serif">Can I use Netscape 7 or
Mozilla   to start or join a meeting?</font></b><br>
Yes. WebEx officially supports Mozilla 1.2.1. Netscape 7 and earlier
versions   of Mozilla should work as well.</p>
<p><b><font face="Arial, Helvetica, sans-serif">How do I set up my
Linux computer   to use WebEx?<br>
</font></b>1. Go to your WebEx site<br>
2. Click <b>Set Up</b> in the navigation bar, then click <b>Meeting
Manager</b>. <br>
3. Click <b>Download Installer</b> in the Set Up WebEx Meeting Manager
page. <b><br>
</b>4. Click <b>OK</b> in the Downloading wbxsetup-moz.tar.gz dialog
box.<br>
4. Click <b>Save</b> in the Enter name of file to save to... dialog box.<br>
5. Save the file in the root directory. (Do not change the name of the
installer   file.)<br>
6. After downloading, open a terminal window and type the folowing
commands   (these instructions will be presented on screen):</p>
<blockquote>
  <p><b>tar xfz wbxsetup-moz.tar.gz</b><br>
  <b>cd WebExPkg</b><br>
  <b>./INSTALL </b></p>
</blockquote>
<p>7. Type 1 to select Install/Upgrade.<br>
8. Type <b>n</b> to complete the installation without installing the
WebEx X   server extension. This is recommended for most users even to
be a presenter   and use desktop sharing.<br>
</p>
<p>If you have the root password, you can type <b>y</b> to install the
WebEx X   server extension, however this option is not recommended due
to compatibility   issues with Red Hat 8. This enables application and
Web browser sharing. IMPORTANT:   For Red Hat Linux 8.0, you must
restart your computer after installing the X   server extension.<br>
<br>
</p>
<p><b><font face="Arial, Helvetica, sans-serif">How can I share my
desktop (and   all applications) from Linux?</font></b> </p>
<p>1. In the WebEx Meeting Manager, click the <b>Share</b> menu and
select <b>Desktop</b>.<br>
2. Minimize the <b>Share Desktop</b> and <b>Meeting Manager</b> windows
to view   the current desktop.<br>
3. To stop desktop sharing, close the <b>Share Desktop</b> window.</p>
<p><b>Tip:</b> You can use one workspace for the Meeting Manager window
then switch   to another workspace to share applications. WebEx will
always share the desktop   of the workspace that is currently in view.
The keyboard shortcut for switching   workspaces is ctrl-alt-arrow.</p>
<p><b><font face="Arial, Helvetica, sans-serif">How can I share a
specific application   (e.g. OpenOffice) from Linux?</font><br>
</b>Note: Installation of the Xshare extension is required for the
presenter   to use application sharing. This feature has known
compatibility issues with   Red Hat 8 and is not recommended for that
release.</p>
<p>1. Start the application(s) that you want to share.<br>
2. In the WebEx Meeting Manager, click the <b>Share</b> menu and select <b>Application</b>.<br>
3. In the Share Application window that appears, click the <b>Sharing</b>
menu and select <b>Share Application</b>, then select the application
you want to   share from the sub menu.<br>
4. Minimize the <b>Share Application</b> and <b>Meeting Manager</b>
windows to view the shared application on the current desktop.</p>
<p>To stop application sharing, close the <b>Share Application</b>
window.</p>
<p><b><font face="Arial, Helvetica, sans-serif" color="#000000">What
can I do   if attendees cannot see exactly what I am sharing?</font></b><font
 color="#000000"><br>
Try screen sampling mode as follows: </font></p>
<p><font color="#000000">1. Start Desktop sharing.<br>
2. </font><font color="#000000">Click the <b>Sharing</b> menu in the
Share Desktop   window.<br>
3. </font><font color="#000000">Select <b>Switch to... </b>then
select <b>Screen   Sampling Based</b>.</font></p>
<p><font color="#000000">Note: Screen sampling mode may improve the
appearance   of your desktop on attendee's screens.<br>
</font><font color="#cc0000"> </font></p>
<p><b><font face="Arial, Helvetica, sans-serif" color="#000000">What if
I get   disconnected from the meeting?</font></b><br>
No problem. Just go back to the Meeting Center home page and join
again. If   you were the host, be sure to log in first to retain the
host role when you   rejoin the meeting.</p>
<p><font face="Verdana, Arial, Helvetica, sans-serif"><b><font
 face="Verdana, Arial, Helvetica, sans-serif"><b><font
 face="Arial, Helvetica, sans-serif">What   are the known issues and
limitations</font></b></font><font face="Arial, Helvetica, sans-serif">
for WebEx on Linux</font>?<br>
</b></font>* Application sharing may not work well with some
applications. Switch   to desktop sharing and use screen sampling mode.<br>
* Presenters on Linux may not see chat from Attendees when the Attendee
Priviliges   are set to chat with host and presenter only.<br>
* Integrated teleconferencing is not supported in this release. Use
call in   teleconferencing.<br>
* Presentation or Document viewing and sharing are not supported in
this release.   Use desktop or application sharing.<br>
* When sharing the desktop using screen sampling mode, attendees will
not see   the presenter's mouse pointer.<br>
</p>
<p><font face="Verdana, Arial, Helvetica, sans-serif"><b><font
 face="Arial, Helvetica, sans-serif">Support   and Feedback</font><br>
</b></font>Click the <b>Assistance</b> link in the navigation bar on
your Meeting   Center site, then click <b>Support</b> to view the
Support page.<br>
Refer to the Support page to find information for technical support, a
feedback   form, release notes, downloads and more. <br>
<br>
</p>
<hr> <br>
<br>
Joubert Berger wrote:<br>
<blockquote type="cite"
 cite="mid1058893583.7990.45.camel@localhost.localdomain">
  <pre wrap="">Just tried to sign up.  Can't.  They don't support RH9.  What's that all
about?  Anyone know how I can get the WebEx Meeting Manager software?

On Mon, 2003-07-21 at 12:56, Daniel J Walsh wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">I will be giving a webcast talking about SELinux and Red Hat on July 22, 
2003.

<a class="moz-txt-link-freetext" href="https://www.redhat.com//apps/webform.html?event_type=webcast&eid=225">https://www.redhat.com//apps/webform.html?event_type=webcast&amp;eid=225</a>

Dan



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to <a class="moz-txt-link-abbreviated" href="mailto:majordomo@tycho.nsa.gov">majordomo@tycho.nsa.gov</a> with
the words "unsubscribe selinux" without quotes as the message.

    </pre>
  </blockquote>
  <pre wrap=""><!---->
  </pre>
</blockquote>
</body>
</html>

--------------050004030606070708080001--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
