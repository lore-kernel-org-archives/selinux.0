Message-ID: <4B02FE33.9070808@tycho.nsa.gov>
Date: Tue, 17 Nov 2009 14:49:07 -0500
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: "Dyson, Mark L (IS)" <Mark.Dyson@ngc.com>
CC: selinux@tycho.nsa.gov
Subject: Re: Windows-level enforcement in SELinux?
References: <834B41F71BFB1D4385FC5E62CF526DCE01C59D17@XMBIL123.northgrum.com>
In-Reply-To: <834B41F71BFB1D4385FC5E62CF526DCE01C59D17@XMBIL123.northgrum.com>
Content-Type: text/plain; charset=windows-1252
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 11/16/2009 10:08 AM, Dyson, Mark L (IS) wrote:
>
> Hello,
>
> I’ve been tasked to map out a path for migrating a MLS application
> from Trusted Solaris to SELinux. I’m sure I’ll have many questions to
> come, but after some initial readings one of my first is:
>

There is X server support for SELinux policy controlling windows,
selections, and other X objects. I am in the process of upstreaming the
security policy from the demos that Chris linked.


> How does SELinux label individual X-windows in a user session, so that
> (for example) data contained in a high-level security window cannot be
> copied and then pasted into a lower-level security window?
>

The specific answer to this is that the X server allows selection and
window property objects to be polyinstantiated by security context (i.e.
level). In this scenario, copying data from a high-level application
would cause a clipboard selection ownership change only at the
high-level selection instance. The low-level application would not "see"
this. Even if the low-level application managed to issue a
ConvertSelection request to the high-level application, it would not be
able to read the pasted data, because the window property where the
pasted data gets stored is polyinstantiated also.

This is controlled in SELinux using the x_contexts file which allows
polyinstantiated behavior to be specified for selections and properties
by matching on the name.

Making cross-level cut & paste work requires a SELinux-aware clipboard
manager application that has privilege to move data between selection
instances. I have some sample application code written to do this but it
is not in production shape yet. You also need a property manager that
keeps certain common properties consistent on all levels, such as the
various root window properties that specify information about the desktop.



-- 

Eamon Walsh 
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
