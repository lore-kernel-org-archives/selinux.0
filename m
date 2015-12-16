Subject: Re: [PATCH v2] secilc/docs: Convert DocBook documentation into github
 markdown
To: Yuli Khodorkovskiy <ykhodorkovskiy@tresys.com>, selinux@tycho.nsa.gov
References: <1450210407-11327-1-git-send-email-ykhodorkovskiy@tresys.com>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <56717CAF.2090706@tycho.nsa.gov>
Date: Wed, 16 Dec 2015 10:01:03 -0500
MIME-Version: 1.0
In-Reply-To: <1450210407-11327-1-git-send-email-ykhodorkovskiy@tresys.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 12/15/2015 03:13 PM, Yuli Khodorkovskiy wrote:
> Converting to github markdown allows for easier integration with the
> SELinux project wiki and viewing of documentation directly on github without
> creating PDFs or reading through DocBook XML.
>
> The conversion of DocBook to github markdown would not format tables or
> keyword links properly. By maintaining the documentation in github
> markdown in the repository, the content is well formatted with a table of
> contents when viewing in the github wiki or in the repository.
>
> The migration from DocBook to github markdown was done using Pandoc and
> manual fixups. Mappings of CIL keywords to headings that were lost in the DocBook
> conversion were added back. An introduction and design philosphy was
> also pulled from the SELinux project wiki to provide more cohesion
> to the current documentation.
>
> Running make will now convert the github markdown into PDF and HTML.
>
> Signed-off-by: Yuli Khodorkovskiy <ykhodorkovskiy@tresys.com>

Applied.

Thanks,
Jim

> ---
> v2 changes:
> - Update secilc README to reflect documentation changes
> - Drop xelatex as the LaTeX engine for github markdown to PDF
>    conversion. The standard pandoc LaTeX engine works fine and
>      allows us to no longer need dblatex.
>
>   secilc/.gitignore                                  |   1 +
>   secilc/README                                      |  17 +-
>   secilc/docs/CIL_Reference_Guide.xml                | 573 ----------------
>   secilc/docs/Makefile                               |  86 ++-
>   secilc/docs/README.md                              | 154 +++++
>   secilc/docs/cil_access_vector_rules.md             | 428 ++++++++++++
>   secilc/docs/cil_access_vector_rules.xml            | 518 ---------------
>   secilc/docs/cil_call_macro_statements.md           | 130 ++++
>   secilc/docs/cil_call_macro_statements.xml          | 174 -----
>   secilc/docs/cil_class_and_permission_statements.md | 522 +++++++++++++++
>   .../docs/cil_class_and_permission_statements.xml   | 604 -----------------
>   secilc/docs/cil_conditional_statements.md          | 222 +++++++
>   secilc/docs/cil_conditional_statements.xml         | 269 --------
>   secilc/docs/cil_constraint_statements.md           | 313 +++++++++
>   secilc/docs/cil_constraint_statements.xml          | 363 ----------
>   secilc/docs/cil_container_statements.md            | 296 +++++++++
>   secilc/docs/cil_container_statements.xml           | 424 ------------
>   secilc/docs/cil_context_statement.md               |  77 +++
>   secilc/docs/cil_context_statement.xml              | 100 ---
>   secilc/docs/cil_default_object_statements.md       | 183 +++++
>   secilc/docs/cil_default_object_statements.xml      | 215 ------
>   secilc/docs/cil_file_labeling_statements.md        | 228 +++++++
>   secilc/docs/cil_file_labeling_statements.xml       | 302 ---------
>   secilc/docs/cil_introduction.md                    |  59 ++
>   secilc/docs/cil_mls_labeling_statements.md         | 638 ++++++++++++++++++
>   secilc/docs/cil_mls_labeling_statements.xml        | 733 ---------------------
>   secilc/docs/cil_network_labeling_statements.md     | 201 ++++++
>   secilc/docs/cil_network_labeling_statements.xml    | 244 -------
>   secilc/docs/cil_policy_config_statements.md        | 113 ++++
>   secilc/docs/cil_policy_config_statements.xml       | 118 ----
>   secilc/docs/cil_reference_guide.md                 | 298 +++++++++
>   secilc/docs/cil_role_statements.md                 | 320 +++++++++
>   secilc/docs/cil_role_statements.xml                | 374 -----------
>   secilc/docs/cil_sid_statements.md                  | 125 ++++
>   secilc/docs/cil_sid_statements.xml                 | 142 ----
>   secilc/docs/cil_type_statements.md                 | 502 ++++++++++++++
>   secilc/docs/cil_type_statements.xml                | 581 ----------------
>   secilc/docs/cil_user_statements.md                 | 455 +++++++++++++
>   secilc/docs/cil_user_statements.xml                | 528 ---------------
>   secilc/docs/cil_xen_statements.md                  | 200 ++++++
>   secilc/docs/cil_xen_statements.xml                 | 227 -------
>   41 files changed, 5525 insertions(+), 6532 deletions(-)
>   delete mode 100644 secilc/docs/CIL_Reference_Guide.xml
>   create mode 100644 secilc/docs/README.md
>   create mode 100644 secilc/docs/cil_access_vector_rules.md
>   delete mode 100644 secilc/docs/cil_access_vector_rules.xml
>   create mode 100644 secilc/docs/cil_call_macro_statements.md
>   delete mode 100644 secilc/docs/cil_call_macro_statements.xml
>   create mode 100644 secilc/docs/cil_class_and_permission_statements.md
>   delete mode 100644 secilc/docs/cil_class_and_permission_statements.xml
>   create mode 100644 secilc/docs/cil_conditional_statements.md
>   delete mode 100644 secilc/docs/cil_conditional_statements.xml
>   create mode 100644 secilc/docs/cil_constraint_statements.md
>   delete mode 100644 secilc/docs/cil_constraint_statements.xml
>   create mode 100644 secilc/docs/cil_container_statements.md
>   delete mode 100644 secilc/docs/cil_container_statements.xml
>   create mode 100644 secilc/docs/cil_context_statement.md
>   delete mode 100644 secilc/docs/cil_context_statement.xml
>   create mode 100644 secilc/docs/cil_default_object_statements.md
>   delete mode 100644 secilc/docs/cil_default_object_statements.xml
>   create mode 100644 secilc/docs/cil_file_labeling_statements.md
>   delete mode 100644 secilc/docs/cil_file_labeling_statements.xml
>   create mode 100644 secilc/docs/cil_introduction.md
>   create mode 100644 secilc/docs/cil_mls_labeling_statements.md
>   delete mode 100644 secilc/docs/cil_mls_labeling_statements.xml
>   create mode 100644 secilc/docs/cil_network_labeling_statements.md
>   delete mode 100644 secilc/docs/cil_network_labeling_statements.xml
>   create mode 100644 secilc/docs/cil_policy_config_statements.md
>   delete mode 100644 secilc/docs/cil_policy_config_statements.xml
>   create mode 100644 secilc/docs/cil_reference_guide.md
>   create mode 100644 secilc/docs/cil_role_statements.md
>   delete mode 100644 secilc/docs/cil_role_statements.xml
>   create mode 100644 secilc/docs/cil_sid_statements.md
>   delete mode 100644 secilc/docs/cil_sid_statements.xml
>   create mode 100644 secilc/docs/cil_type_statements.md
>   delete mode 100644 secilc/docs/cil_type_statements.xml
>   create mode 100644 secilc/docs/cil_user_statements.md
>   delete mode 100644 secilc/docs/cil_user_statements.xml
>   create mode 100644 secilc/docs/cil_xen_statements.md
>   delete mode 100644 secilc/docs/cil_xen_statements.xml
>



-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
