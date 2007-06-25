Subject: Re: regarding privilege granting
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Steve G <linux_4ever@yahoo.com>, selinux@tycho.nsa.gov,
        Joshua Brindle <method@manicmethod.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <1182790991.5636.87.camel@moss-spartans.epoch.ncsc.mil>
References: <20070625162622.42210.qmail@web51503.mail.re2.yahoo.com>
	 <1182790991.5636.87.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 25 Jun 2007 13:45:34 -0400
Message-Id: <1182793534.27126.24.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-06-25 at 13:03 -0400, Stephen Smalley wrote:
> On Mon, 2007-06-25 at 09:26 -0700, Steve G wrote:
> > >I'm pretty surprised that you are making the argument that these method
> > >of granting capabilities is harder to analyze. SELinux allows you to
> > >understand exactly what domains have the capabilities in exactly which
> > >situations. Since executable code is tightly bound to the domains
> > >already finding executables that can run with additional capabilities it
> > >not hard.
> > 
> > OK, what would I type at the command line to get the list of all apps with
> > elevated privileges? I already showed you the 1 line in bash that finds all
> > programs with elevated privileges today.
> 
> Doesn't exist today, but not hard to do as an extension to sesearch I
> would think - search policy for all allow rules on cap_override class,
> then find the entrypoint types for those domains, then feed that list of
> types to a find command.
> 
> The fact that we don't have a one-line command line to do it today is
> hardly surprising given that the kernel functionality is only just being
> proposed.
> 

Python script for this below - most of the scripting is just converting
output from one command for input to another. Note that this just finds
entrypoints that can reach domains with cap_override. Much more thorough
and interesting analysis of how the capabilities are used can be done
reflecting the better control over capabilities that selinux provides
over the current mechanism.

This was tested using the capabilities class - I don't have a system
with the cap_override object so I would appreciate testing from someone
that does.

Karl

# Authors: Karl MacMillan <kmacmillan@mentalrootkit.com>
#
# Copyright (C) 2007  Red Hat
# see file 'COPYING' for use and warranty information
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; version 2 only
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
#

import commands
import subprocess

def find_cap_domains():
    out = commands.getoutput("/usr/bin/sesearch --allow -c cap_override")
    domains = []
    for line in out.split("\n"):
        s = line.lstrip().split()
        if len(s) < 2 or s[0] != "allow":
            continue
        domains.append(s[1])
    return domains

def find_entrypoints(domains):
    entrypoints = { }
    search = "|".join(domains)
    out = commands.getoutput("/usr/bin/sesearch --allow -s '%s' -p entrypoint" % search)
    for line in out.split("\n"):
        s = line.lstrip().split()
        if len(s) < 3 or s[0] != "allow":
            continue
        entrypoints[s[2]] = ''

    return entrypoints

def find_files(domains):
    contexts = []
    for domain in domains.keys():
        contexts.append("-context '*:*:%s'" % domain)

    search = " -or ".join(contexts)
    cmd = "/usr/bin/find . \( %s \) -print0 | xargs -0 ls -Z" % search

    subprocess.call(cmd, shell=True)

def main():
    cap_domains = find_cap_domains()
    entrypoints = find_entrypoints(cap_domains)
    find_files(entrypoints)

main()



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
