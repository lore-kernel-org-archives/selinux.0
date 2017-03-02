Message-ID: <1488472236.19896.39.camel@tycho.nsa.gov>
Subject: Re: seapply - alternative to semanage for configuration management
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Doug Brown <dgbrown@redhat.com>, selinux@tycho.nsa.gov
Date: Thu, 02 Mar 2017 11:30:36 -0500
In-Reply-To: <744a0953-a3a5-ad1a-aa47-889829c39be9@redhat.com>
References: <744a0953-a3a5-ad1a-aa47-889829c39be9@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2017-03-02 at 12:29 +1000, Doug Brown wrote:
> Hi list,
> 
> Some SELinux configurations can't be included in policy and require
> the
> use of semanage. This is fine in some cases, such as the installation
> of
> services by package management, but the use of `semanage -i` doesn't
> lend itself well to applying and enforcing certain local changes
> (e.g.
> RBAC mappings) using configuration management tools (Ansible, puppet,
> etc.).
> 
> To address this, I've created a new command 'seapply'
> (https://github.com/doksu/seapply), which takes a JSON representation
> of
> the desired configuration and compares it to the local running
> configuration. Iff discrepancies exist, it rectifies those specific
> differences. In this way, a configuration management tool can run the
> seapply command frequently without reapplying all the local SELinux
> configuration customisations each time (which significantly slows
> down
> the application of configuration management policies).
> 
> Any suggestions or feedback? Would it be possible to bring this into
> the
> tool set?

Wondering if it should be part of semanage or kept separate.
Not opposed to adding it under selinux/python.
